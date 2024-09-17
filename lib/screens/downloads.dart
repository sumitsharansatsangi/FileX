import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filex/providers/provider.dart';
import 'package:filex/widgets/custom_divider.dart';
import 'package:filex/widgets/custom_loader.dart';
import 'package:filex/widgets/file_item.dart';
import 'package:flutter/material.dart';

class Downloads extends ConsumerWidget {
  final String title;

  const Downloads({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloads = ref.watch(downloadProvider);
    return downloads.when(data: (data) {
      return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: ListView.separated(
            padding: const EdgeInsets.only(left: 20),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return FileItem(file: data[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const CustomDivider();
            },
          ));
    }, error: (data, err) {
      return Text("error occurred",
          style: Theme.of(context).textTheme.titleLarge);
    }, loading: () {
      return const CustomLoader();
    });
  }
}
