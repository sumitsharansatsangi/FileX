import 'package:isar/isar.dart';
import 'package:filex/models/model.dart';

class ModelManager {
  final Isar isar;
  final Model model;
  ModelManager(this.isar, this.model);

  Future<void> changeTheme(bool darkTheme) async {
      await isar.writeTxn(() async {
        model.darkTheme = darkTheme;
        await isar.models.put(model);
      });
  }

  Future<void> changeSort(int sort) async {
    await isar.writeTxn(() async {
        model.sort = sort;
        await isar.models.put(model);
    });
  }

  Future<void> changeHidden(bool hidden) async {
    await isar.writeTxn(() async {
        model.hidden = hidden;
        await isar.models.put(model);
    });
  }
}
