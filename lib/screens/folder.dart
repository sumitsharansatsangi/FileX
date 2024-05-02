import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filex/providers/category_provider.dart';
import 'package:filex/utils/dialogs.dart';
import 'package:filex/utils/file_utils.dart';
import 'package:filex/widgets/custom_divider.dart';
import 'package:filex/widgets/dir_item.dart';
import 'package:filex/widgets/file_item.dart';
import 'package:filex/widgets/path_bar.dart';
import 'package:filex/widgets/sort_sheet.dart';
import 'package:path/path.dart' as pathlib;
import 'package:share_plus/share_plus.dart';

import '../widgets/add_file_dialog.dart';
import '../widgets/rename_file_dialog.dart';

class Folder extends ConsumerStatefulWidget {
  final String title;
  final String path;

  const Folder({
    super.key,
    required this.title,
    required this.path,
  });

  @override
  FolderState createState() => FolderState();
}

class FolderState extends ConsumerState<Folder> with WidgetsBindingObserver {
  late String path;
  List<String> paths = <String>[];

  List<FileSystemEntity> files = <FileSystemEntity>[];
  bool showHidden = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getFiles();
    }
  }

  getFiles() async {
    try {
   final model = ref.watch(modelManagerProvider);
   model.whenData((value) {
      Directory dir = Directory(path);
      List<FileSystemEntity> dirFiles = dir.listSync();
      files.clear();
      showHidden = value.model.hidden;
      setState(() {});
      for (FileSystemEntity file in dirFiles) {
        if (!showHidden) {
          if (!pathlib.basename(file.path).startsWith('.')) {
            files.add(file);
            setState(() {});
          }
        } else {
          files.add(file);
          setState(() {});
        }
      }

      files = FileUtils.sortList(files, value.model.sort);

   });
      
    } catch (e) {
      if (e.toString().contains('Permission denied')) {
        Dialogs.showToast( Text('Permission Denied! cannot access this Directory!', style: Theme.of(context).textTheme.titleLarge,));
        navigateBack();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    path = widget.path;
    getFiles();
    paths.add(widget.path);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  navigateBack() {
    paths.removeLast();
    path = paths.last;
    setState(() {});
    getFiles();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (paths.length == 1) {
          return true;
        } else {
          paths.removeLast();
          setState(() {
            path = paths.last;
          });
          getFiles();
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (paths.length == 1) {
                Navigator.pop(context);
              } else {
                navigateBack();
              }
            },
          ),
          elevation: 4,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.title),
              Text(
                path,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          bottom: PathBar(
            paths: paths,
            icon: widget.path.toString().contains('emulated')
                ? Feather.smartphone
                : Icons.sd_card,
            onChanged: (index) {
              debugPrint(paths[index]);
              path = paths[index];
              paths.removeRange(index + 1, paths.length);
              setState(() {});
              getFiles();
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (context) => const SortSheet(),
                );
                getFiles();
              },
              tooltip: 'Sort by',
              icon: const Icon(Icons.sort),
            ),
          ],
        ),
        body: Visibility(
          replacement: const Center(child: Text('There\'s nothing here')),
          visible: files.isNotEmpty,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 20),
            itemCount: files.length,
            itemBuilder: (BuildContext context, int index) {
              FileSystemEntity file = files[index];
              if (file.toString().split(':')[0] == 'Directory') {
                return DirectoryItem(
                  popTap: (v) async {
                    if (v == 0) {
                      await renameDialog(context, file.path, 'dir');
                    } else if (v == 1) {
                      await deleteFile(context,true, file);
                    } else if (v == 2) {
                      await shareFile(true, file);
                    }
                  },
                  file: file,
                  tap: () {
                    paths.add(file.path);
                    path = file.path;
                    setState(() {});
                    getFiles();
                  },
                );
              }
              return FileItem(
                file: file.path,
                popTap: (v) async {
                  if (v == 0) {
                    await renameDialog(context, file.path, 'file');
                  } else if (v == 1) {
                    await deleteFile(context, false, file);
                  } else if (v == 2) {
                    await shareFile(false, file);
                  }
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const CustomDivider();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addDialog(context, path),
          tooltip: 'Add Folder',
          child: const Icon(Feather.plus),
        ),
      ),
    );
  }

  shareFile(bool directory, var file) async {
    try {
      if (directory) {
        final fileList = Directory(file.path).list(recursive: true);
        List<XFile> files = [];
        await for (final file in fileList) {
          if (FileSystemEntity.isFileSync(file.path)) {
            if (pathlib.basename(file.path).startsWith('.')) {
              files.add(XFile(file.path));
            }
          }
        }
        await Share.shareXFiles(files);
      } else {
        await Share.shareXFiles([XFile(file.path)]);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  deleteFile(BuildContext context, bool directory, var file) async {
    try {
      if (directory) {
        await Directory(file.path).delete(recursive: true);
      } else {
        await File(file.path).delete(recursive: true);
      }
      if(context.mounted) {
        Dialogs.showToast( Text('Delete Successful', style: Theme.of(context).textTheme.titleLarge,));
      }
    } catch (e) {
      debugPrint(e.toString());
      if (e.toString().contains('Permission denied')) {
        if(context.mounted) {
          Dialogs.showToast( Text('Cannot write to this Storage device!',  style: Theme.of(context).textTheme.titleLarge,));
        }
      }
    }
    getFiles();
  }

  addDialog(BuildContext context, String path) async {
    await showDialog(
      context: context,
      builder: (context) => AddFileDialog(path: path),
    );
    getFiles();
  }

  renameDialog(BuildContext context, String path, String type) async {
    await showDialog(
      context: context,
      builder: (context) => RenameFileDialog(path: path, type: type),
    );
    getFiles();
  }
}
