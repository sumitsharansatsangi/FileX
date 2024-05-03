import 'dart:io';
import 'package:filex/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filex/providers/provider.dart';
import 'package:filex/utils/consts.dart';
import 'package:filex/utils/dialogs.dart';
import 'package:filex/utils/extensions.dart';
import 'package:filex/utils/file_utils.dart';
import 'package:filex/utils/strings.dart';
import 'package:mime_type/mime_type.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart';

class WhatsappStatus extends StatelessWidget {
  final String title;
  final String path;
  final List<FileSystemEntity> files;
  WhatsappStatus({super.key, required this.title, required this.path})
      : files = Directory(path).listSync()..removeWhere((f) => f.isHidden);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverGrid.count(
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              crossAxisCount: 2,
              children: Constants.map(
                files,
                (index, item) {
                  FileSystemEntity f = files[index];
                  String path = f.path;
                  File file = File(path);
                  String? mimeType = mime(path);
                  return mimeType == null
                      ? const SizedBox()
                      : WhatsAppItem(
                          file: file,
                          path: path,
                          mimeType: mimeType,
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WhatsAppItem extends StatelessWidget {
  final File file;
  final String path;
  final String mimeType;

  const WhatsAppItem({
    super.key,
    required this.file,
    required this.path,
    required this.mimeType,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => OpenFilex.open(file.path),
      child: GridTile(
        header: SizedBox(
          height: 50.0,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black54, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => saveMedia(context),
                      icon: const Icon(
                        Feather.download,
                        color: Colors.white,
                        size: 16.0,
                      ),
                    ),
                    mimeType.split('/')[0] == 'video'
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                FileUtils.formatBytes(file.lengthSync(), 1),
                                style: const TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                              const SizedBox(width: 5.0),
                              const Icon(
                                Icons.play_circle_filled,
                                color: Colors.white,
                                size: 16.0,
                              ),
                            ],
                          )
                        : Text(
                            FileUtils.formatBytes(file.lengthSync(), 1),
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
        child: mimeType.split('/')[0] == 'video'
            ? Consumer(
                builder: (context, ref, child) {
                  final thumbnail = ref.watch(getThumbnailProvider(path));
                  return thumbnail.when(data: (t) {
                    if (t != null) {
                      return Image.memory(t);
                    } else {
                      return Image.asset(
                        'assets/video-placeholder.png',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      );
                    }
                  }, error: (a, b) {
                    return Image.asset(
                      'assets/video-placeholder.png',
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    );
                  }, loading: () {
                    return const CustomLoader();
                  });
                },
              )
            : Image(
                fit: BoxFit.cover,
                errorBuilder: (b, o, c) {
                  return const Icon(Icons.image);
                },
                image: ResizeImage(
                  FileImage(File(file.path)),
                  width: 150,
                  height: 150,
                ),
              ),
      ),
    );
  }

  Future<void> saveMedia(BuildContext context) async {
    String rootPath = '/storage/emulated/0/';
    await Directory('$rootPath${AppStrings.appName}').create();
    await Directory('$rootPath${AppStrings.appName}/Whatsapp Status').create();
    await file.copy(
        '$rootPath${AppStrings.appName}/Whatsapp Status/${basename(path)}');
    Dialogs.showToast('Saved!');
  }
}
