import 'dart:io';
import 'package:filex/providers/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filex/screens/apps_screen.dart';
import 'package:filex/screens/non_visible_media.dart';
import 'package:filex/screens/downloads.dart';
import 'package:filex/screens/visible_media.dart';
import 'package:filex/screens/search.dart';
import 'package:filex/screens/whatsapp_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:filex/utils/consts.dart';
import 'package:filex/utils/dialogs.dart';
import 'package:filex/utils/file_utils.dart';
import 'package:filex/utils/navigate.dart';
import 'package:filex/utils/strings.dart';
import 'package:filex/widgets/custom_divider.dart';
import 'package:filex/widgets/file_item.dart';
import 'package:filex/widgets/storage_item.dart';

class Browse extends StatelessWidget {
  const Browse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.appName,
          style: const TextStyle(fontSize: 25.0),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(themeData: Theme.of(context)),
              );
            },
            icon: const Icon(Feather.search),
          )
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ref.watch(checkSpaceProvider.future);
          return RefreshIndicator(
            onRefresh: () {
              ref.read(recentFileProvider);
              return ref.refresh(checkSpaceProvider.future);
            },
            child: ListView(
              padding: const EdgeInsets.only(left: 20.0),
              children: <Widget>[
                const SizedBox(height: 20.0),
                const _SectionTitle('Storage Devices'),
                _StorageSection(),
                const CustomDivider(),
                const SizedBox(height: 20.0),
                const _SectionTitle('Categories'),
                _CategoriesSection(),
                const CustomDivider(),
                const SizedBox(height: 20.0),
                const _SectionTitle('Recent Files'),
                _RecentFiles(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
          color: Theme.of(context).textTheme.titleSmall!.color),
    );
  }
}

class _StorageSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableStorage = ref.watch(availableStorageProvider);
    final totalSpace = ref.watch(totalSpaceProvider);
    final usedSpace = ref.watch(usedSpaceProvider);
    final totalSDSpace = ref.watch(totalSpaceProvider);
    final usedSDSpace = ref.watch(usedSpaceProvider);
    if (availableStorage.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: availableStorage.length,
      itemBuilder: (BuildContext context, int index) {
        FileSystemEntity item = availableStorage[index];
        String path = item.path.split('Android')[0];
        double percent = 0;
        if (index == 0) {
          percent = calculatePercent(usedSpace, totalSpace);
        } else {
          percent = calculatePercent(usedSDSpace, totalSDSpace);
        }
        return StorageItem(
          percent: percent,
          path: path,
          title: index == 0 ? 'Device' : 'SD Card',
          icon: index == 0 ? Feather.smartphone : Icons.sd_storage,
          color: index == 0
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).cardColor,
          usedSpace: index == 0 ? usedSpace : usedSDSpace,
          totalSpace: index == 0 ? totalSpace : totalSDSpace,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const CustomDivider();
      },
    );
  }

  calculatePercent(int usedSpace, int totalSpace) {
    return double.parse((usedSpace / totalSpace * 100).toStringAsFixed(0)) /
        100;
  }
}

class _CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Constants.categories.length,
      itemBuilder: (BuildContext context, int index) {
        Map category = Constants.categories[index];

        return Consumer(
          builder: (context, ref, child) {
            return ListTile(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigate.pushPage(
                        context, Downloads(title: '${category['title']}'));
                    break;
                  case 1:
                    Navigate.pushPage(
                        context, VisibleMedia(title: '${category['title']}'));
                    break;
                  case 2:
                    Navigate.pushPage(
                        context, VisibleMedia(title: '${category['title']}'));
                    break;
                  case 3:
                    ref.read(getAudioProvider('audio'));
                    Navigate.pushPage(
                        context, NonVisibleMedia(title: category['title']));
                    break;
                  case 4:
                    ref.read(getAudioProvider('text'));
                    Navigate.pushPage(
                        context, NonVisibleMedia(title: category['title']));
                    break;
                  case 5:
                    Navigate.pushPage(context, const AppScreen());
                    break;
                  case 6:
                    if (Directory(FileUtils.waPath1).existsSync()) {
                      Navigate.pushPage(
                        context,
                        WhatsappStatus(
                            title: category['title'], path: FileUtils.waPath1),
                      );
                    } else if (Directory(FileUtils.waPath2).existsSync()) {
                      Navigate.pushPage(
                        context,
                        WhatsappStatus(
                            title: category['title'], path: FileUtils.waPath2),
                      );
                    } else {
                      Dialogs.showToast(
                          'Please Install WhatsApp to use this feature');
                    }
                    break;
                }
              },
              contentPadding: const EdgeInsets.all(0),
              leading: SizedBox(
                height: 40,
                width: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 2,
                    ),
                  ),
                  child: Icon(category['icon'],
                      size: 18, color: category['color']),
                ),
              ),
              title: Text(
                '${category['title']}',
                style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge!.color),
              ),
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const CustomDivider();
      },
    );
  }
}

class _RecentFiles extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentfiles = ref.watch(recentFileProvider);
    if (recentfiles.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.separated(
      padding: const EdgeInsets.only(right: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recentfiles.length > 5 ? 5 : recentfiles.length,
      itemBuilder: (BuildContext context, int index) {
        String file = recentfiles[index];
        return File(file).existsSync()
            ? FileItem(file: file)
            : const SizedBox();
      },
      separatorBuilder: (BuildContext context, int index) {
        return const CustomDivider();
      },
    );
  }
}
