import 'package:flutter/material.dart';

class DirPopup extends StatelessWidget {
  final String path;
  final Function? popTap;

  const DirPopup({
    super.key,
    required this.path,
    this.popTap,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      surfaceTintColor: Theme.of(context).colorScheme.secondaryContainer,
      onSelected: (val) => popTap!(val),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Text(
            'Rename',
            style:
                TextStyle(color: Theme.of(context).textTheme.titleSmall!.color),
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Text(
            'Delete',
            style:
                TextStyle(color: Theme.of(context).textTheme.titleSmall!.color),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            'Share',
            style:
                TextStyle(color: Theme.of(context).textTheme.titleSmall!.color),
          ),
        ),
      ],
      icon: Icon(
        Icons.arrow_drop_down,
        color: Theme.of(context).textTheme.titleLarge!.color,
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      offset: const Offset(0, 30),
    );
  }
}
