import 'dart:io';
import 'package:flutter/material.dart';
import 'package:filex/utils/dialogs.dart';
import 'package:filex/widgets/custom_alert.dart';
import 'package:path/path.dart' as pathlib;

class RenameFileDialog extends StatefulWidget {
  final String path;
  final String type;

  const RenameFileDialog({super.key, required this.path, required this.type});

  @override
  RenameFileDialogState createState() => RenameFileDialogState();
}

class RenameFileDialogState extends State<RenameFileDialog> {
  final TextEditingController name = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.text = pathlib.basename(widget.path);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlert(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 15),
            const Text(
              'Rename Item',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: name,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).colorScheme.secondaryContainer),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        side: WidgetStateProperty.all(
                          BorderSide(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (name.text.isNotEmpty) {
                          if (widget.type == 'file') {
                            if (!File(
                                    '${widget.path.replaceAll(pathlib.basename(widget.path), '')}${name.text}')
                                .existsSync()) {
                              await File(widget.path)
                                  .rename(
                                      '${widget.path.replaceAll(pathlib.basename(widget.path), '')}${name.text}')
                                  .catchError((e) {
                                debugPrint(e.toString());
                                if (e
                                    .toString()
                                    .contains('Permission denied')) {
                                  Dialogs.showToast(
                                      'Cannot write to this device!');
                                }
                                return File("");
                              });
                            } else {
                              Dialogs.showToast(
                                  'A File with that name already exists!');
                            }
                          } else {
                            if (Directory(
                                    '${widget.path.replaceAll(pathlib.basename(widget.path), '')}${name.text}')
                                .existsSync()) {
                              Dialogs.showToast(
                                  'A Folder with that name already exists!');
                            } else {
                              await Directory(widget.path)
                                  .rename(
                                      '${widget.path.replaceAll(pathlib.basename(widget.path), '')}${name.text}')
                                  .catchError((e) {
                                debugPrint(e.toString());
                                if (e
                                    .toString()
                                    .contains('Permission denied')) {
                                  Dialogs.showToast(
                                      'Cannot write to this device!');
                                }
                                return Directory("");
                              });
                            }
                          }
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).colorScheme.secondary),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Rename',
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
