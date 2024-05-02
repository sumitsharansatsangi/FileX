import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:isolate_handler/isolate_handler.dart';
import 'package:filex/utils/file_utils.dart';
import 'package:path_provider/path_provider.dart';

class CoreManager {
  List<FileSystemEntity> availableStorage = <FileSystemEntity>[];
  List<String> recentFiles = <String>[];
  final isolates = IsolateHandler();
  int totalSpace = 0;
  int freeSpace = 0;
  int totalSDSpace = 0;
  int freeSDSpace = 0;
  int usedSpace = 0;
  int usedSDSpace = 0;
  bool storageLoading = true;
  bool recentLoading = true;

 Future<void> checkSpace() async {
    setRecentLoading(true);
    setStorageLoading(true);
    recentFiles.clear();
    availableStorage.clear();
    List<Directory> dirList = (await getExternalStorageDirectories())!;
    availableStorage.addAll(dirList);
    MethodChannel platform = const MethodChannel('com.kumpali.filex/storage');
    var free = await platform.invokeMethod('getStorageFreeSpace');
    var total = await platform.invokeMethod('getStorageTotalSpace');
    setFreeSpace(free);
    setTotalSpace(total);
    setUsedSpace(total - free);
    if (dirList.length > 1) {
      var freeSD = await platform.invokeMethod('getExternalStorageFreeSpace');
      var totalSD = await platform.invokeMethod('getExternalStorageTotalSpace');
      setFreeSDSpace(freeSD);
      setTotalSDSpace(totalSD);
      setUsedSDSpace(totalSD - freeSD);
    }
    setStorageLoading(false);
    getRecentFiles();
  }

  /// I had to use a combination of [isolate_handler] plugin and
  /// [IsolateNameServer] because compute doesnt work as my function uses
  /// an external plugin and also [isolate_handler] plugin doesnt allow me
  /// to pass complex data (in this case List<FileSystemEntity>). so basically
  /// i used the [isolate_handler] to do get the file and use [IsolateNameServer]
  /// to send it back to the main Thread
 Future<void> getRecentFiles() async {
    String isolateName = 'recent';
    String isolateName2='${isolateName}_2';
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
      recentFiles.addAll(message);
      setRecentLoading(false);
      port.close();
      IsolateNameServer.removePortNameMapping(isolateName2);
    });
  }

  static Future<void> getFilesWithIsolate(Map<String, dynamic> context) async {
    debugPrint(context.toString());
    String isolateName = context['name'];
    String isolateName2 = '${isolateName}_2';
    List<FileSystemEntity> files =
        await FileUtils.getRecentFiles(showHidden: false);
    final messenger = HandledIsolate.initialize(context);
    final SendPort? send =
        IsolateNameServer.lookupPortByName(isolateName2);
    send?.send([for (final f in files) f.path]);
    messenger.send('done');
  }

  void setFreeSpace(value) {
    freeSpace = value;
  }

  void setTotalSpace(value) {
    totalSpace = value;
  }

  void setUsedSpace(value) {
    usedSpace = value;
  }

  void setFreeSDSpace(value) {
    freeSDSpace = value;
  }

  void setTotalSDSpace(value) {
    totalSDSpace = value;
  }

  void setUsedSDSpace(value) {
    usedSDSpace = value;
  }

  void setStorageLoading(value) {
    storageLoading = value;
  }

  void setRecentLoading(value) {
    recentLoading = value;
  }
}
