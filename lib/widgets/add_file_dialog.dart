import 'dart:io';
import 'package:flutter/material.dart';
import 'package:filex/utils/dialogs.dart';
import 'package:filex/widgets/custom_alert.dart';

class AddFileDialog extends StatelessWidget {
  final String path;

  AddFileDialog({super.key, required this.path});

  final TextEditingController name = TextEditingController();

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
              'Add New Folder',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        side: MaterialStateProperty.all(
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
                Expanded(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (name.text.isNotEmpty) {
                          if (!Directory('$path/${name.text}').existsSync()) {
                            await Directory('$path/${name.text}')
                                .create()
                                .catchError((e) {
                              debugPrint(e.toString());
                              if (e.toString().contains('Permission denied')) {
                                Dialogs.showToast(
                                    'Cannot write to this Storage  device!');
                              }
                              return Directory("");
                            });
                          } else {
                            Dialogs.showToast(
                                'A Folder with that name already exists!');
                          }
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.secondary),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Create',
                        style: TextStyle(color: Colors.white),
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
