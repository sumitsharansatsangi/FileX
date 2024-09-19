import 'dart:io';
import 'dart:typed_data';

import 'package:filex/widgets/add_file_dialog.dart';
import 'package:filex/widgets/rename_file_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart';

import 'dialogs.dart';

Future<void> shareGalleryFile(List<MediaFile> files) async {
  try {
    List<XFile> xFiles = [];
    for (final file in files) {
      if (file.file != null) {
        xFiles.add(XFile(file.file!.path));
      }
    }
    await Share.shareXFiles(xFiles);
  } catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> shareFile(bool directory, var file) async {
  try {
    if (directory) {
      final fileList = Directory(file.path).list(recursive: true);
      List<XFile> files = [];
      await for (final file in fileList) {
        if (FileSystemEntity.isFileSync(file.path)) {
          if (basename(file.path).startsWith('.')) {
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

void openEditor(BuildContext context, File file) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProImageEditor.file(
        file,
        callbacks: ProImageEditorCallbacks(
          onImageEditingComplete: (Uint8List bytes) async {
            final directory = await getApplicationDocumentsDirectory();
            final newDirectory = Directory('${directory.path}/filex/images');
            await newDirectory.create(recursive: true);
            final pathOfImage = await File(
                    '${newDirectory.path}/${basenameWithoutExtension(file.path)}_${getFormattedDateTime()}.jpg')
                .create();
            await pathOfImage.writeAsBytes(bytes);
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ),
    ),
  );
}

String getFormattedDateTime() {
  final now = DateTime.now();
  final formatter = DateFormat('yyyyMMdd_HHmmss');
  return formatter.format(now);
}
