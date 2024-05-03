import 'dart:io';
import 'package:filex/providers/core_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filex/providers/category_provider.dart';
import 'package:filex/screens/folder.dart';
import 'package:filex/utils/navigate.dart';
import 'package:filex/widgets/custom_divider.dart';
import 'package:filex/widgets/custom_loader.dart';
import 'package:filex/widgets/dir_item.dart';
import 'package:filex/widgets/file_item.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final ThemeData themeData;

  Search({
    Key? key,
    required this.themeData,
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = themeData;
    return theme.copyWith(
      primaryTextTheme: theme.primaryTextTheme,
      textTheme: theme.textTheme.copyWith(
        displayLarge: theme.textTheme.displayLarge!.copyWith(
          color: theme.primaryTextTheme.titleLarge!.color,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: theme.primaryTextTheme.titleLarge!.color,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final searchFiles = ref.watch(searchFilesProvider(query));
        return searchFiles.when(data: (data) {
          if (data.isEmpty) {
            return Center(
                child: Text(
              'No file match your query!',
              style: Theme.of(context).textTheme.titleLarge,
            ));
          } else {
            return ListView.separated(
              padding: const EdgeInsets.only(left: 20),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                FileSystemEntity file = data[index];
                if (file.toString().split(':')[0] == 'Directory') {
                  return DirectoryItem(
                    popTap: null,
                    file: file,
                    tap: () {
                      ref.read(pathsProvider.notifier).addNew(file.path);
                      ref.read(pathProvider.notifier).update(file.path);
                      ref.read(filesProvider.notifier).getFiles();
                      Navigate.pushPage(
                        context,
                        const Folder(title: 'Storage'),
                      );
                    },
                  );
                }
                return FileItem(file: file.path, popTap: null);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const CustomDivider();
              },
            );
          }
        }, error: (data, err) {
          return const Text("Error occurred");
        }, loading: () {
          return const CustomLoader();
        });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final searchFiles = ref.watch(searchFilesProvider(query));
        return searchFiles.when(data: (data) {
          if (data.isEmpty) {
            return Center(
                child: Text(
              'No file match your query!',
              style: Theme.of(context).textTheme.titleLarge,
            ));
          } else {
            return ListView.separated(
              padding: const EdgeInsets.only(left: 20),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                FileSystemEntity file = data[index];
                if (file.toString().split(':')[0] == 'Directory') {
                  return DirectoryItem(
                    popTap: null,
                    file: file,
                    tap: () {
                      ref.read(pathsProvider.notifier).addNew(file.path);
                      ref.read(pathProvider.notifier).update(file.path);
                      Navigate.pushPage(
                        context,
                        const Folder(title: 'Storage'),
                      );
                    },
                  );
                }
                return FileItem(file: file.path, popTap: null);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const CustomDivider();
              },
            );
          }
        }, error: (data, err) {
          return const Text("Error occurred");
        }, loading: () {
          return const CustomLoader();
        });
      },
    );
  }
}
