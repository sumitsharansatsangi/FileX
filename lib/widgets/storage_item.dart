import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filex/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:filex/screens/folder.dart';
import 'package:filex/utils/file_utils.dart';
import 'package:filex/utils/navigate.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StorageItem extends ConsumerWidget {
  final double percent;
  final String title;
  final String path;
  final Color color;
  final IconData icon;
  final int usedSpace;
  final int totalSpace;

  const StorageItem({
    super.key,
    required this.percent,
    required this.title,
    required this.path,
    required this.color,
    required this.icon,
    required this.usedSpace,
    required this.totalSpace,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        ref.read(pathProvider.notifier).update(path);
        ref.read(filesProvider.notifier).getFiles();
        ref.read(pathsProvider.notifier).addNew(path);
        Navigate.pushPage(
          context,
          Folder(title: title),
        );
      },
      contentPadding: const EdgeInsets.only(right: 20),
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
          child: Center(
            child: Icon(icon, color: color),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            '${FileUtils.formatBytes(usedSpace, 2)} '
            'used of ${FileUtils.formatBytes(totalSpace, 2)}',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
          ),
        ],
      ),
      subtitle: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: LinearPercentIndicator(
          padding: const EdgeInsets.all(0),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          percent: percent,
          progressColor: color,
        ),
      ),
    );
  }
}
