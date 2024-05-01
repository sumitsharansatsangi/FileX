import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:filex/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider() {
    getHidden();
    getSort();
  }

  bool loading = false;
  List<String> downloads = <String>[];
  List<String> downloadTabs = <String>[];

  List<String> images = <String>[];
  List<String> imageTabs = <String>[];

  List<String> audio = <String>[];
  List<String> audioTabs = <String>[];
  List<String> currentFiles = [];

  bool showHidden = false;
  int sort = 0;
  final isolates = IsolateHandler();

  getDownloads() async {
    setLoading(true);
    downloadTabs.clear();
    downloads.clear();
    downloadTabs.add('All');
    List<Directory> storages = await FileUtils.getStorageList();

    storages.forEach((dir) {
      if (Directory(dir.path + 'Download').existsSync()) {
        List<FileSystemEntity> files =
            Directory(dir.path + 'Download').listSync();
        debugPrint(files.toString());
        files.forEach((file) {
          if (FileSystemEntity.isFileSync(file.path)) {
            downloads.add(file.path);
            downloadTabs
                .add(file.path.split('/')[file.path.split('/').length - 2]);
            downloadTabs = downloadTabs.toSet().toList();
            notifyListeners();
          }
        });
      }
    });
    setLoading(false);
  }

  getImages(String type) {
    setLoading(true);
    imageTabs.clear();
    images.clear();
    imageTabs.add('All');
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
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(_port.sendPort, isolateName2);
    _port.listen((files) {
      debugPrint('RECEIVED SERVER PORT');
      for (final file in files) {
        String mimeType = mime(file) ?? '';
        if (mimeType.split('/')[0] == type) {
          images.add(file);
          imageTabs.add('${file.split('/')[file.split('/').length - 2]}');
        }
      }
      imageTabs = imageTabs.toSet().toList();
      notifyListeners();
      currentFiles = images;
      setLoading(false);
      _port.close();
      IsolateNameServer.removePortNameMapping(isolateName2);
    });
  }

  static getAllFilesWithIsolate(Map<String, dynamic> context) async {
    debugPrint(context.toString());
    String isolateName = context['name'];
    String isolateName2 = '${isolateName}_2';
    debugPrint('Get files');
    List<FileSystemEntity> files =
        await FileUtils.getAllFiles(showHidden: false);
    debugPrint('Files $files');
    debugPrint(files.length.toString());
    final messenger = HandledIsolate.initialize(context);
    try {
      final SendPort? send =
          IsolateNameServer.lookupPortByName(isolateName2);
      send!.send([for (final f in files) f.path]);
    } catch (e) {
      debugPrint(e.toString());
    }
    messenger.send('done');
  }

  getAudios(String type) {
    setLoading(true);
    audioTabs.clear();
    audio.clear();
    audioTabs.add('All');
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
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(_port.sendPort, isolateName2);
    _port.listen((files) async {
      debugPrint('RECEIVED SERVER PORT');
      debugPrint(files.toString());
      List tabs = await compute(separateAudios, {'files': files, 'type': type});
      audio = tabs[0];
      audioTabs = tabs[1];
      setLoading(false);
      _port.close();
      IsolateNameServer.removePortNameMapping(isolateName2);
    });
  }

  Future<void> switchCurrentFiles(List list, String label) async {
    List<String> l = await compute(getTabImages, [list, label]);
    currentFiles = l.map((e) => e).toList();
    notifyListeners();
  }

  static List<String> getTabImages(List item){
    List items = item[0];
    String label = item[1];
    List<String> files = [];
    items.forEach((file) {
      if ('${file.split('/')[file.split('/').length - 2]}' == label) {
        files.add(file);
      }
    });
    return files;
  }

  static List separateAudios(Map body) {
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

  static List docExtensions = [
    '.pdf',
    '.epub',
    '.mobi',
    '.doc',
  ];

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  setHidden(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hidden', value);
    showHidden = value;
    notifyListeners();
  }

  getHidden() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool h = prefs.getBool('hidden') ?? false;
    setHidden(h);
  }

  Future setSort(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('sort', value);
    sort = value;
    notifyListeners();
  }

  getSort() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int h = prefs.getInt('sort') ?? 0;
    setSort(h);
  }
}
