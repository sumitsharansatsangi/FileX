import 'dart:io';

import 'package:filex/utils/utils.dart';
import 'package:filex/widgets/file_icon.dart';
import 'package:filex/widgets/file_popup.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart';

class FileItem extends StatelessWidget {
  final FileSystemEntity file;
  final Function? popTap;

  FileItem({
    Key? key,
    required this.file,
    this.popTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => OpenFilex.open(file.path),
      contentPadding: EdgeInsets.all(0),
      leading: FileIcon(file: file),
      title: Text(
        '${basename(file.path)}',
        style: TextStyle(fontSize: 14),
        maxLines: 2,
      ),
      subtitle: Text(
        '${FileUtils.formatBytes(File(file.path).lengthSync(), 2)},'
        ' ${FileUtils.formatTime(File(file.path).lastModifiedSync().toIso8601String())}',
      ),
      trailing:
          popTap == null ? null : FilePopup(path: file.path, popTap: popTap!),
    );
  }
}
