import 'package:isar/isar.dart';

part 'model.g.dart';

@collection
class Model {
  final int id;
  final bool darkTheme;
  final bool hidden;
  final int sort;
 Model(this.id, this.darkTheme,this.hidden, this.sort);
}
