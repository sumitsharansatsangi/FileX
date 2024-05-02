import 'dart:io';


import 'package:flutter/material.dart';
import 'package:filex/utils/file_utils.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart';

import 'file_icon.dart';
import 'file_popup.dart';

class FileItem extends StatelessWidget {
  final String file;
  final Function? popTap;

  const FileItem({
    super.key,
    required this.file,
    this.popTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => OpenFilex.open(file),
      contentPadding: const EdgeInsets.all(0),
      leading: FileIcon(file: file),
      title: Text(
        basename(file),
        style: TextStyle(
            fontSize: 14, color: Theme.of(context).textTheme.titleSmall!.color),
        maxLines: 2,
      ),
      subtitle: Text(
        '${FileUtils.formatBytes(File(file).lengthSync(), 2)},'
        ' ${FileUtils.formatTime(File(file).lastModifiedSync().toIso8601String())}',
        style: TextStyle(
            color: Theme.of(context)
                .textTheme
                .titleSmall!
                .color!
                .withOpacity(0.6)),
      ),
      trailing: popTap == null ? null : FilePopup(path: file, popTap: popTap!),
    );
  }
}
