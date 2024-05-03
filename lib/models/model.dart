import 'package:isar/isar.dart';

part 'model.g.dart';

@collection
class Model {
  Id? id;
  late bool darkTheme;
  late bool hidden;
  late int sort;
  
  Model copyWith({ int? sort, bool? darkTheme, bool? hidden}) => Model()
    .. id = id 
    ..sort= sort ?? this.sort
    ..hidden = hidden ?? this.hidden
    ..darkTheme = darkTheme ?? this.darkTheme
    ;

}

