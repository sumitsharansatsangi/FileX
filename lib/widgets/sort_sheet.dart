import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:filex/providers/provider.dart';
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
                      final model = ref.watch(modelManagerProvider);
                      return ListTile(
                        onTap: () async {
                          await ref
                              .read(modelManagerProvider.notifier)
                              .changeSort(index);
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        contentPadding: const EdgeInsets.all(0),
                        trailing: index == model.sort
                            ? const Icon(
                                Feather.check,
                                color: Colors.teal,
                                size: 16,
                              )
                            : const SizedBox(),
                        title: Text(
                          '${Constants.sortList[index]}',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: index == model.sort
                                ? Colors.teal
                                : Theme.of(context).textTheme.titleLarge!.color,
                          ),
                        ),
                      );
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
