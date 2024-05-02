import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:filex/utils/file_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'core_provider.g.dart';


@riverpod
 List<FileSystemEntity> availableStorage( AvailableStorageRef ref ){
    return <FileSystemEntity>[];
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
Future<void> checkSpaceAndRecentFiles(
    CheckSpaceAndRecentFilesRef ref) async {
  List<Directory>? dirList = await getExternalStorageDirectories();
  if (dirList != null) {
    ref.read(availableStorageProvider).clear();
    ref.read(availableStorageProvider).addAll(dirList);
    MethodChannel platform = const MethodChannel('com.kumpali.filex/storage');
    final free = await platform.invokeMethod('getStorageFreeSpace');
    final total = await platform.invokeMethod('getStorageTotalSpace');
    ref.read(totalSpaceProvider.notifier).assign(total);
    ref.read(usedSpaceProvider.notifier).assign(total-free);
    if (dirList.length > 1) {
      var freeSD = await platform.invokeMethod('getExternalStorageFreeSpace');
      var totalSD = await platform.invokeMethod('getExternalStorageTotalSpace');
      ref.read(usedSDSpaceProvider.notifier).assign(totalSD-freeSD);
      ref.read(totalSDSpaceProvider.notifier).assign(totalSD);
    }
    final isolates = IsolateHandler();
    String isolateName = 'recent';
    String isolateName2 = '${isolateName}_2';
    isolates.spawn<String>(
      getFilesWithIsolate,
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
      debugPrint('RECEIVED SERVER PORT');
        ref.read(recentFileProvider).clear();    
     ref.read(recentFileProvider.notifier).update(message);
      port.close();
      IsolateNameServer.removePortNameMapping(isolateName2);
    });
  }
}

Future<void> getFilesWithIsolate(Map<String, dynamic> context) async {
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
