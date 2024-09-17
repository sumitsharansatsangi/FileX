// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetModelCollection on Isar {
  IsarCollection<int, Model> get models => this.collection();
}

const ModelSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'Model',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'darkTheme',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'hidden',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'sort',
        type: IsarType.long,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, Model>(
    serialize: serializeModel,
    deserialize: deserializeModel,
    deserializeProperty: deserializeModelProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeModel(IsarWriter writer, Model object) {
  IsarCore.writeBool(writer, 1, object.darkTheme);
  IsarCore.writeBool(writer, 2, object.hidden);
  IsarCore.writeLong(writer, 3, object.sort);
  return object.id;
}

@isarProtected
Model deserializeModel(IsarReader reader) {
  final int _id;
  _id = IsarCore.readId(reader);
  final bool _darkTheme;
  _darkTheme = IsarCore.readBool(reader, 1);
  final bool _hidden;
  _hidden = IsarCore.readBool(reader, 2);
  final int _sort;
  _sort = IsarCore.readLong(reader, 3);
  final object = Model(
    _id,
    _darkTheme,
    _hidden,
    _sort,
  );
  return object;
}

@isarProtected
dynamic deserializeModelProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readBool(reader, 1);
    case 2:
      return IsarCore.readBool(reader, 2);
    case 3:
      return IsarCore.readLong(reader, 3);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _ModelUpdate {
  bool call({
    required int id,
    bool? darkTheme,
    bool? hidden,
    int? sort,
  });
}

class _ModelUpdateImpl implements _ModelUpdate {
  const _ModelUpdateImpl(this.collection);

  final IsarCollection<int, Model> collection;

  @override
  bool call({
    required int id,
    Object? darkTheme = ignore,
    Object? hidden = ignore,
    Object? sort = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (darkTheme != ignore) 1: darkTheme as bool?,
          if (hidden != ignore) 2: hidden as bool?,
          if (sort != ignore) 3: sort as int?,
        }) >
        0;
  }
}

sealed class _ModelUpdateAll {
  int call({
    required List<int> id,
    bool? darkTheme,
    bool? hidden,
    int? sort,
  });
}

class _ModelUpdateAllImpl implements _ModelUpdateAll {
  const _ModelUpdateAllImpl(this.collection);

  final IsarCollection<int, Model> collection;

  @override
  int call({
    required List<int> id,
    Object? darkTheme = ignore,
    Object? hidden = ignore,
    Object? sort = ignore,
  }) {
    return collection.updateProperties(id, {
      if (darkTheme != ignore) 1: darkTheme as bool?,
      if (hidden != ignore) 2: hidden as bool?,
      if (sort != ignore) 3: sort as int?,
    });
  }
}

extension ModelUpdate on IsarCollection<int, Model> {
  _ModelUpdate get update => _ModelUpdateImpl(this);

  _ModelUpdateAll get updateAll => _ModelUpdateAllImpl(this);
}

sealed class _ModelQueryUpdate {
  int call({
    bool? darkTheme,
    bool? hidden,
    int? sort,
  });
}

class _ModelQueryUpdateImpl implements _ModelQueryUpdate {
  const _ModelQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<Model> query;
  final int? limit;

  @override
  int call({
    Object? darkTheme = ignore,
    Object? hidden = ignore,
    Object? sort = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (darkTheme != ignore) 1: darkTheme as bool?,
      if (hidden != ignore) 2: hidden as bool?,
      if (sort != ignore) 3: sort as int?,
    });
  }
}

extension ModelQueryUpdate on IsarQuery<Model> {
  _ModelQueryUpdate get updateFirst => _ModelQueryUpdateImpl(this, limit: 1);

  _ModelQueryUpdate get updateAll => _ModelQueryUpdateImpl(this);
}

class _ModelQueryBuilderUpdateImpl implements _ModelQueryUpdate {
  const _ModelQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<Model, Model, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? darkTheme = ignore,
    Object? hidden = ignore,
    Object? sort = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (darkTheme != ignore) 1: darkTheme as bool?,
        if (hidden != ignore) 2: hidden as bool?,
        if (sort != ignore) 3: sort as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension ModelQueryBuilderUpdate on QueryBuilder<Model, Model, QOperations> {
  _ModelQueryUpdate get updateFirst =>
      _ModelQueryBuilderUpdateImpl(this, limit: 1);

  _ModelQueryUpdate get updateAll => _ModelQueryBuilderUpdateImpl(this);
}

extension ModelQueryFilter on QueryBuilder<Model, Model, QFilterCondition> {
  QueryBuilder<Model, Model, QAfterFilterCondition> idEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Model, Model, QAfterFilterCondition> idGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Model, Model, QAfterFilterCondition> idGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Model, Model, QAfterFilterCondition> idLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Model, Model, QAfterFilterCondition> idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Model, Model, QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<Model, Model, QAfterFilterCondition> darkThemeEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Model, Model, QAfterFilterCondition> hiddenEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Model, Model, QAfterFilterCondition> sortEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Model, Model, QAfterFilterCondition> sortGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Model, Model, QAfterFilterCondition> sortGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Model, Model, QAfterFilterCondition> sortLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Model, Model, QAfterFilterCondition> sortLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<Model, Model, QAfterFilterCondition> sortBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }
}

extension ModelQueryObject on QueryBuilder<Model, Model, QFilterCondition> {}

extension ModelQuerySortBy on QueryBuilder<Model, Model, QSortBy> {
  QueryBuilder<Model, Model, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> sortByDarkTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> sortByDarkThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> sortByHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> sortByHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> sortBySort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> sortBySortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }
}

extension ModelQuerySortThenBy on QueryBuilder<Model, Model, QSortThenBy> {
  QueryBuilder<Model, Model, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> thenByDarkTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> thenByDarkThemeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> thenByHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> thenByHiddenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> thenBySort() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<Model, Model, QAfterSortBy> thenBySortDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }
}

extension ModelQueryWhereDistinct on QueryBuilder<Model, Model, QDistinct> {
  QueryBuilder<Model, Model, QAfterDistinct> distinctByDarkTheme() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1);
    });
  }

  QueryBuilder<Model, Model, QAfterDistinct> distinctByHidden() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<Model, Model, QAfterDistinct> distinctBySort() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }
}

extension ModelQueryProperty1 on QueryBuilder<Model, Model, QProperty> {
  QueryBuilder<Model, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Model, bool, QAfterProperty> darkThemeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Model, bool, QAfterProperty> hiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Model, int, QAfterProperty> sortProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension ModelQueryProperty2<R> on QueryBuilder<Model, R, QAfterProperty> {
  QueryBuilder<Model, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Model, (R, bool), QAfterProperty> darkThemeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Model, (R, bool), QAfterProperty> hiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Model, (R, int), QAfterProperty> sortProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension ModelQueryProperty3<R1, R2>
    on QueryBuilder<Model, (R1, R2), QAfterProperty> {
  QueryBuilder<Model, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Model, (R1, R2, bool), QOperations> darkThemeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Model, (R1, R2, bool), QOperations> hiddenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Model, (R1, R2, int), QOperations> sortProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}
