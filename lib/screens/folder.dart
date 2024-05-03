import 'dart:io';
import 'package:filex/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filex/utils/dialogs.dart';
import 'package:filex/widgets/custom_divider.dart';
import 'package:filex/widgets/dir_item.dart';
import 'package:filex/widgets/file_item.dart';
import 'package:filex/widgets/path_bar.dart';
import 'package:filex/widgets/sort_sheet.dart';
import 'package:path/path.dart' as pathlib;
import 'package:share_plus/share_plus.dart';

import '../widgets/add_file_dialog.dart';
import '../widgets/rename_file_dialog.dart';

class Folder extends ConsumerWidget {
  final String title;

  const Folder({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final files = ref.watch(filesProvider);
    final paths = ref.watch(pathsProvider);
    final path = ref.watch(pathProvider);
    if (files.isEmpty) {
      return Image.asset("assets/no_files_found.png");
    }

    return WillPopScope(
      onWillPop: () async {
        if (paths.length == 1) {
          return true;
        } else {
          ref.read(pathsProvider.notifier).removeLast();
          ref.read(pathProvider.notifier).update(paths.last);
          ref.read(filesProvider.notifier).getFiles();
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
                ref.read(pathsProvider.notifier).removeLast();
                ref
                    .read(pathProvider.notifier)
                    .update(ref.read(pathsProvider).last);
                ref.read(filesProvider.notifier).getFiles();
              }
            },
          ),
          elevation: 4,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title),
              Text(
                paths.last,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          bottom: PathBar(
            paths: paths,
            icon: paths.last.toString().contains('emulated')
                ? Feather.smartphone
                : Icons.sd_card,
            onChanged: (index) {
              debugPrint(paths[index]);
              ref.read(pathProvider.notifier).update(paths[index]);
              ref.read(pathsProvider.notifier).removeRange(index + 1);
              ref.read(filesProvider.notifier).getFiles();
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (context) => const SortSheet(),
                );
                ref.read(filesProvider.notifier).getFiles();
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
                      ref.read(filesProvider.notifier).getFiles();
                    } else if (v == 1) {
                      await deleteFile(true, file);
                      ref.read(filesProvider.notifier).getFiles();
                    } else if (v == 2) {
                      await shareFile(true, file);
                    }
                  },
                  file: file,
                  tap: () {
                    ref.read(pathsProvider.notifier).addNew(file.path);
                    ref.read(pathProvider.notifier).update(file.path);
                    ref.read(filesProvider.notifier).getFiles();
                  },
                );
              }
              return FileItem(
                file: file.path,
                popTap: (v) async {
                  if (v == 0) {
                    await renameDialog(context, file.path, 'file');
                    ref.read(filesProvider.notifier).getFiles();
                  } else if (v == 1) {
                    await deleteFile(false, file);
                    ref.read(filesProvider.notifier).getFiles();
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
          onPressed: () async {
            await addDialog(context, path);
            ref.read(filesProvider.notifier).getFiles();
          },
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

  Future<void> deleteFile(bool directory, var file) async {
    try {
      if (directory) {
        await Directory(file.path).delete(recursive: true);
      } else {
        await File(file.path).delete(recursive: true);
      }
      Dialogs.showToast('Delete Successful');
    } catch (e) {
      debugPrint(e.toString());
      if (e.toString().contains('Permission denied')) {
        Dialogs.showToast('Cannot write to this Storage device!');
      }
    }
  }

  Future<void> addDialog(BuildContext context, String path) async {
    await showDialog(
      context: context,
      builder: (context) => AddFileDialog(path: path),
    );
  }

  Future<void> renameDialog(
      BuildContext context, String path, String type) async {
    await showDialog(
      context: context,
      builder: (context) => RenameFileDialog(path: path, type: type),
    );
  }
}
