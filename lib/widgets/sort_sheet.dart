import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filex/providers/category_provider.dart';
import 'package:filex/utils/consts.dart';

class SortSheet extends StatelessWidget {
  const SortSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.85,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            Text(
              'Sort by'.toUpperCase(),
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: ListView.builder(
                itemCount: Constants.sortList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Consumer(
                    builder: (context, ref, child) {
                      final modelManager = ref.watch(modelManagerProvider);
                     return  modelManager.when(data: (data) {
                        return ListTile(
                          onTap: () async {
                            await data.changeSort(index);
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          contentPadding: const EdgeInsets.all(0),
                          trailing: index == data.model.sort
                              ? const Icon(
                                  Feather.check,
                                  color: Colors.blue,
                                  size: 16,
                                )
                              : const SizedBox(),
                          title: Text(
                            '${Constants.sortList[index]}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: index ==
                                     data.model.sort
                                  ? Colors.blue
                                  : Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .color,
                            ),
                          ),
                        );
                      }, error: (data, err) {
                        return const Text("Errror");
                      }, loading: () {
                        return const CircularProgressIndicator();
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
