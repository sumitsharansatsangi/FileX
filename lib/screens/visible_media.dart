import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filex/providers/provider.dart';
import 'package:filex/utils/consts.dart';
import 'package:filex/utils/file_utils.dart';
import 'package:filex/widgets/file_icon.dart';
import 'package:mime_type/mime_type.dart';
import 'package:open_filex/open_filex.dart';

class VisibleMedia extends ConsumerWidget {
  final String title;

  const VisibleMedia({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageTabs = ref.watch(imageTabsProvider);
    final List<String> images;
    if (title.toLowerCase() == "images") {
      images = ref.watch(imageProvider('image'));
    } else {
      images = ref.watch(imageProvider('video'));
    }
    final currentFiles = ref.watch(currentFileProvider);

    if (images.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      length: imageTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primaryContainer,
            labelColor: Theme.of(context).colorScheme.primaryContainer,
            unselectedLabelColor: Theme.of(context).textTheme.titleSmall!.color,
            isScrollable: imageTabs.length < 3 ? false : true,
            tabs: Constants.map<Widget>(
              imageTabs,
              (index, label) {
                return Tab(text: '$label');
              },
            ),
            onTap: (val) => ref
                .read(currentFileProvider.notifier)
                .switchCurrentFiles(images, imageTabs[val]),
          ),
        ),
        body: Visibility(
          visible: images.isNotEmpty,
          replacement: const Center(child: Text('No Files Found')),
          child: TabBarView(
            children: Constants.map<Widget>(
              imageTabs,
              (index, label) {
                List l = currentFiles;
                return CustomScrollView(
                  primary: false,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.all(10.0),
                      sliver: SliverGrid.count(
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        crossAxisCount: 2,
                        children: Constants.map(
                          index == 0 ? images : l.reversed.toList(),
                          (index, item) {
                            String mimeType = mime(item) ?? '';
                            return _MediaTile(file: item, mimeType: mimeType);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _MediaTile extends StatelessWidget {
  final String file;
  final String mimeType;

  const _MediaTile({required this.file, required this.mimeType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => OpenFilex.open(file),
      child: GridTile(
        header: SizedBox(
          height: 50,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black54, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: mimeType.split('/')[0] == 'video'
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            FileUtils.formatBytes(File(file).lengthSync(), 1),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.play_circle_filled,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      )
                    : Text(
                        FileUtils.formatBytes(File(file).lengthSync(), 1),
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
              ),
            ),
          ),
        ),
        child: mimeType.split('/')[0] == 'video'
            ? FileIcon(file: file)
            : Image(
                fit: BoxFit.cover,
                errorBuilder: (b, o, c) {
                  return const Icon(Icons.image);
                },
                image: ResizeImage(
                  FileImage(File(file)),
                  width: 150,
                  height: 150,
                ),
              ),
      ),
    );
  }
}
