import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filex/providers/category_provider.dart';
import 'package:filex/utils/consts.dart';
import 'package:filex/widgets/custom_divider.dart';
import 'package:filex/widgets/file_item.dart';

class NonVisibleMedia extends ConsumerWidget {
  final String title;

  const NonVisibleMedia({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioTabs = ref.watch(audioTabsProvider);
    final audios = ref.watch(audioProvider);
    if (audios.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return DefaultTabController(
      length: audioTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primaryContainer,
            labelColor: Theme.of(context).colorScheme.primaryContainer,
            unselectedLabelColor: Theme.of(context).textTheme.titleSmall!.color,
            isScrollable: audioTabs.length < 3 ? false : true,
            tabs: Constants.map<Widget>(
              audioTabs,
              (index, label) {
                debugPrint('tabs');
                return Tab(text: '$label');
              },
            ),
          ),
        ),
        body: audios.isEmpty
            ? Center(
                child: Text('No Files Found',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.labelSmall!.color)))
            : TabBarView(
                children: Constants.map<Widget>(
                  audioTabs,
                  (index, label) {
                    debugPrint(label);
                    List list = [];
                    List items = audios;
                    for (final file in items) {
                      if ('${file.split('/')[file.split('/').length - 2]}' ==
                          label) {
                        list.add(file);
                      }
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.only(left: 20),
                      itemCount: index == 0 ? audios.length : list.length,
                      itemBuilder: (BuildContext context, int index2) {
                        final String file =
                            index == 0 ? audios[index2] : list[index2];
                        return FileItem(file: file);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const CustomDivider();
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}
