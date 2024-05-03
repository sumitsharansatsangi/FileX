import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:filex/models/model.dart';
import 'package:filex/utils/file_utils.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:filex/utils/dialogs.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isarInstance(IsarInstanceRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open([ModelSchema], directory: dir.path);
}

@Riverpod(keepAlive: true)
class ThemeModeManager extends _$ThemeModeManager {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  void toggleDark() {
    state = ThemeMode.dark;
  }

  void toggleLight() {
    state = ThemeMode.light;
  }
}

@Riverpod(keepAlive: true)
class ModelManager extends _$ModelManager {
  @override
  Model build() {
    readDatabase();
    return Model()
      ..darkTheme = true
      ..hidden = false
      ..sort = 0;
  }

  Future<void> readDatabase() async {
    final isar = await ref.read(isarInstanceProvider.future);
    final model = await isar.models.get(1);
    if (model != null) {
      state = model;
    }
  }

  Future<void> changeTheme(bool darkTheme) async {
    state = state.copyWith(darkTheme: darkTheme);
    final isar = await ref.read(isarInstanceProvider.future);
    await isar.writeTxn(() async {
      await isar.models.put(state);
    });
  }

  Future<void> changeSort(int sort) async {
    state = state.copyWith(sort: sort);
    final isar = await ref.read(isarInstanceProvider.future);
    await isar.writeTxn(() async {
      await isar.models.put(state);
    });
  }

  Future<void> changeHidden(bool hidden) async {
    state = state.copyWith(hidden: hidden);
    final isar = await ref.read(isarInstanceProvider.future);
    await isar.writeTxn(() async {
      await isar.models.put(state);
    });
  }
}

@riverpod
Future<List<FileSystemEntity>> searchFiles(
  SearchFilesRef ref,
  String query,
) async {
  List<Directory> storage = await FileUtils.getStorageList();
  List<FileSystemEntity> files = <FileSystemEntity>[];
  final model = ref.read(modelManagerProvider);
  for (Directory dir in storage) {
    List fs =
        await FileUtils.getAllFilesInPath(dir.path, showHidden: model.hidden);
    for (FileSystemEntity fs in fs) {
      if (basename(fs.path).toLowerCase().contains(query.toLowerCase())) {
        files.add(fs);
      }
    }
  }
  return files;
}

@riverpod
Future<Uint8List?> getThumbnail(GetThumbnailRef ref, String file) async {
  return await VideoThumbnail.thumbnailData(
    video: file,
    imageFormat: ImageFormat.JPEG,
    maxWidth: 128,
    quality: 25,
  );
}

@riverpod
class DownloadTabs extends _$DownloadTabs {
  @override
  List<String> build() {
    return ['All'];
  }

  void makeUnique() {
    state = state.toSet().toList();
  }
}

@riverpod
class AudioTabs extends _$AudioTabs {
  @override
  List<String> build() {
    return <String>[];
  }

  void makeUnique() {
    state = state.toSet().toList();
  }
}

@riverpod
class CurrentFile extends _$CurrentFile {
  @override
  List<String> build() {
    return <String>[];
  }

  Future<void> switchCurrentFiles(List list, String label) async {
    List<String> l = await compute(getTabImages, [list, label]);
    state = l.map((e) => e).toList();
  }

  List<String> getTabImages(List item) {
    List items = item[0];
    String label = item[1];
    List<String> files = [];
    for (final file in items) {
      if ('${file.split('/')[file.split('/').length - 2]}' == label) {
        files.add(file);
      }
    }
    return files;
  }
}

@riverpod
class ImageTabs extends _$ImageTabs {
  @override
  List<String> build() {
    return <String>[];
  }

  void makeUnique() {
    state = state.toSet().toList();
  }
}

@pragma('vm:entry-point')
Future<void> getAllFilesWithIsolate(Map<String, dynamic> context) async {
  debugPrint(context.toString());
  String isolateName = context['name'];
  String isolateName2 = '${isolateName}_2';
  List<FileSystemEntity> files = await FileUtils.getAllFiles(showHidden: false);
  final messenger = HandledIsolate.initialize(context);
  try {
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName2);
    send!.send([for (final f in files) f.path]);
  } catch (e) {
    debugPrint(e.toString());
  }
  messenger.send('done');
}

List docExtensions = [
  '.pdf',
  '.epub',
  '.mobi',
  '.doc',
];
List<List<String>> separateAudios(Map body) {
  List files = body['files'];
  String type = body['type'];
  List<String> audio = [];
  List<String> audioTabs = [];
  for (final file in files) {
    String mimeType = mime(file) ?? '';
    debugPrint(extension(file));
    if (type == 'text' && docExtensions.contains(extension(file))) {
      audio.add(file);
    }
    if (mimeType.isNotEmpty) {
      if (mimeType.split('/')[0] == type) {
        audio.add(file);
        audioTabs.add('${file.split('/')[file.split('/').length - 2]}');
        audioTabs = audioTabs.toSet().toList();
      }
    }
  }
  return [audio, audioTabs];
}

List<String> getTabImages(List item) {
  List items = item[0];
  String label = item[1];
  List<String> files = [];
  for (final file in items) {
    if ('${file.split('/')[file.split('/').length - 2]}' == label) {
      files.add(file);
    }
  }
  return files;
}

@riverpod
class Audio extends _$Audio {
  @override
  List<String> build() {
    return <String>[];
  }

  void update(List<String> value) {
    state = value;
  }
}

@riverpod
void getAudio(GetAudioRef ref, String type) {
  String isolateName = type;
  String isolateName2 = '${isolateName}_2';
  final isolates = IsolateHandler();
  isolates.spawn<String>(
    getAllFilesWithIsolate,
    name: isolateName,
    onReceive: (val) {
      debugPrint(val.toString());
      isolates.kill(isolateName);
    },
    onInitialized: () => isolates.send('hey', to: isolateName),
  );
  ReceivePort port = ReceivePort();
  IsolateNameServer.registerPortWithName(port.sendPort, isolateName2);
  port.listen((files) async {
    debugPrint('RECEIVED SERVER PORT');
    debugPrint(files.toString());
    List tabs = await compute(separateAudios, {'files': files, 'type': type});
    ref.read(audioProvider.notifier).update(tabs[0]);
    ref.read(audioTabsProvider).addAll(tabs[1]);
    port.close();
    IsolateNameServer.removePortNameMapping(isolateName2);
  });
}

@riverpod
Future<List<String>> download(DownloadRef ref) async {
  List<String> downloads = [];
  List<Directory> storages = await FileUtils.getStorageList();
  for (final dir in storages) {
    if (Directory('${dir.path}Download').existsSync()) {
      List<FileSystemEntity> files =
          Directory('${dir.path}Download').listSync();
      debugPrint(files.toString());
      for (var file in files) {
        if (FileSystemEntity.isFileSync(file.path)) {
          downloads.add(file.path);
          ref
              .read(downloadTabsProvider)
              .add(file.path.split('/')[file.path.split('/').length - 2]);
        }
      }
      ref.read(downloadTabsProvider.notifier).makeUnique();
    }
  }
  return downloads;
}

@riverpod
List<String> image(ImageRef ref, String type) {
  List<String> images = [];
  final isolates = IsolateHandler();
  String isolateName = type;
  String isolateName2 = '${isolateName}_2';
  isolates.spawn<String>(
    getAllFilesWithIsolate,
    name: isolateName,
    onReceive: (val) {
      debugPrint(val.toString());
      isolates.kill(isolateName);
    },
    onInitialized: () => isolates.send('hey', to: isolateName),
  );
  ReceivePort port = ReceivePort();
  IsolateNameServer.registerPortWithName(port.sendPort, isolateName2);
  port.listen((files) {
    debugPrint('RECEIVED SERVER PORT');
    for (final file in files) {
      String mimeType = mime(file) ?? '';
      if (mimeType.split('/')[0] == type) {
        images.add(file);
        ref
            .read(imageTabsProvider)
            .add('${file.split('/')[file.split('/').length - 2]}');
      }
    }
    ref.read(imageTabsProvider.notifier).makeUnique();
    ref.read(currentFileProvider).clear();
    ref.read(currentFileProvider).addAll(images);
    port.close();
    IsolateNameServer.removePortNameMapping(isolateName2);
  });
  return images;
}

@Riverpod(keepAlive: true)
class Path extends _$Path {
  @override
  String build() => "";
  void update(String path) {
    state = path;
  }
}

@Riverpod(keepAlive: true)
class Paths extends _$Paths {
  @override
  List<String> build() => <String>[];
  void addNew(String path) {
    state = [...state, path];
  }

  void removeLast() => state.removeLast();
  void removeRange(index) {
    state.removeRange(index + 1, ref.read(pathsProvider).length);
  }
}

@Riverpod(keepAlive: true)
class Files extends _$Files {
  @override
  List<FileSystemEntity> build() => <FileSystemEntity>[];

  Future<void> getFiles() async {
    try {
      final model = ref.read(modelManagerProvider);
      Directory dir = Directory(ref.read(pathProvider));
      List<FileSystemEntity> dirFiles = dir.listSync();
      state = [];
      for (FileSystemEntity file in dirFiles) {
        if (!model.hidden) {
          if (!basename(file.path).startsWith('.')) {
            state = [...state, file];
          }
        } else {
          state = [...state, file];
        }
      }
      state = FileUtils.sortList(state, model.sort);
    } catch (e) {
      if (e.toString().contains('Permission denied')) {
        Dialogs.showToast('Permission Denied! cannot access this Directory!');
        ref.read(pathsProvider.notifier).removeLast();
        ref.read(pathProvider.notifier).update(ref.read(pathsProvider).last);
        getFiles();
      }
    }
  }
}

@riverpod
List<FileSystemEntity> availableStorage(AvailableStorageRef ref) {
  return <FileSystemEntity>[];
}

@riverpod
class TotalSpace extends _$TotalSpace {
  @override
  int build() => 0;
  void assign(int val) => state = val;
}

@riverpod
class UsedSpace extends _$UsedSpace {
  @override
  int build() => 0;
  void assign(int val) => state = val;
}

@riverpod
class TotalSDSpace extends _$TotalSDSpace {
  @override
  int build() => 0;
  void assign(int val) => state = val;
}

@riverpod
class UsedSDSpace extends _$UsedSDSpace {
  @override
  int build() => 0;
  void assign(int val) => state = val;
}

@riverpod
Future<void> checkSpace(CheckSpaceRef ref) async {
  List<Directory>? dirList = await getExternalStorageDirectories();
  if (dirList != null) {
    ref.read(availableStorageProvider).clear();
    ref.read(availableStorageProvider).addAll(dirList);
    MethodChannel platform = const MethodChannel('com.kumpali.filex/storage');
    final free = await platform.invokeMethod('getStorageFreeSpace');
    final total = await platform.invokeMethod('getStorageTotalSpace');
    ref.read(totalSpaceProvider.notifier).assign(total);
    ref.read(usedSpaceProvider.notifier).assign(total - free);
    if (dirList.length > 1) {
      var freeSD = await platform.invokeMethod('getExternalStorageFreeSpace');
      var totalSD = await platform.invokeMethod('getExternalStorageTotalSpace');
      ref.read(usedSDSpaceProvider.notifier).assign(totalSD - freeSD);
      ref.read(totalSDSpaceProvider.notifier).assign(totalSD);
    }
  }
  final isolates = IsolateHandler();
  String isolateName = 'recent';
  String isolateName2 = '${isolateName}_2';
  isolates.spawn<String>(
    getRecentFilesWithIsolate,
    name: isolateName,
    onReceive: (val) {
      debugPrint(val);
      isolates.kill(isolateName);
    },
    onInitialized: () => isolates.send('hey', to: isolateName),
  );
  ReceivePort port = ReceivePort();
  IsolateNameServer.registerPortWithName(port.sendPort, isolateName2);
  port.listen((message) {
    debugPrint('RECEIVED SERVER PORT in Recent Files');
    ref.read(recentFileProvider).clear();
    ref.read(recentFileProvider.notifier).update(message);
    port.close();
    IsolateNameServer.removePortNameMapping(isolateName2);
  });
}

@riverpod
class RecentFile extends _$RecentFile {
  @override
  List<String> build() {
    return <String>[];
  }

  void update(List<String> value) {
    state = value;
  }
}

@pragma('vm:entry-point')
Future<void> getRecentFilesWithIsolate(Map<String, dynamic> context) async {
  debugPrint(context.toString());
  String isolateName = context['name'];
  String isolateName2 = '${isolateName}_2';
  List<FileSystemEntity> files =
      await FileUtils.getRecentFiles(showHidden: false);
  final messenger = HandledIsolate.initialize(context);
  final SendPort? send = IsolateNameServer.lookupPortByName(isolateName2);
  send?.send([for (final f in files) f.path]);
  messenger.send('done');
}
