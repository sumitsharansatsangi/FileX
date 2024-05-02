import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:filex/providers/category_provider.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileIcon extends StatelessWidget {
  final String file;

  const FileIcon({
    super.key,
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    String ext = extension(file).toLowerCase();
    String mimeType = mime(basename(file).toLowerCase()) ?? '';
    String type = mimeType.isEmpty ? '' : mimeType.split('/')[0];
    if (ext == '.apk') {
      return const Icon(Icons.android, color: Colors.green);
    } else if (ext == '.crdownload') {
      return const Icon(Feather.download, color: Colors.lightBlue);
    } else if (ext == '.zip' || ext.contains('tar')) {
      return const Icon(Feather.archive);
    } else if (ext == '.epub' || ext == '.pdf' || ext == '.mobi') {
      return const Icon(Feather.file_text, color: Colors.orangeAccent);
    } else {
      switch (type) {
        case 'image':
          return SizedBox(
            width: 50,
            height: 50,
            child: Image(
              errorBuilder: (b, o, c) {
                return const Icon(Icons.image);
              },
              image: ResizeImage(FileImage(File(file)), width: 50, height: 50),
            ),
          );
        case 'video':
          return SizedBox(
            height: 40,
            width: 40,
            child: Consumer(
              builder: (context, ref, child) {
                final thumbnail = ref.watch(getThumbnailProvider(file));
                return thumbnail.when(data: (t) {
                   if(t!=null){
                    return Image.memory(t);
                    }else{
                      return const Icon(Icons.error);
                    }
                }, error: (a, b) {
                  return const Text("Error");
                }, loading: () {
                  return const Center(child: CircularProgressIndicator());
                });
              },
            ),
          );
        case 'audio':
          return const Icon(Feather.music, color: Colors.teal);
        case 'text':
          return const Icon(Feather.file_text, color: Colors.orangeAccent);
        default:
          return const Icon(Feather.file);
      }
    }
  }
}
