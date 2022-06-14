// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Favorite extends DataClass implements Insertable<Favorite> {
  final int id;
  final double lat;
  final double lng;
  final String name;
  final String urls;
  final String placeType;
  final String description;
  final DateTime? plannedDate;
  final bool isVisited;
  final double? distance;
  Favorite(
      {required this.id,
      required this.lat,
      required this.lng,
      required this.name,
      required this.urls,
      required this.placeType,
      required this.description,
      this.plannedDate,
      required this.isVisited,
      this.distance});
  factory Favorite.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Favorite(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      lat: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lat'])!,
      lng: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lng'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      urls: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}urls'])!,
      placeType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}place_type'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      plannedDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}planned_date']),
      isVisited: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_visited'])!,
      distance: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}distance']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    map['name'] = Variable<String>(name);
    map['urls'] = Variable<String>(urls);
    map['place_type'] = Variable<String>(placeType);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || plannedDate != null) {
      map['planned_date'] = Variable<DateTime?>(plannedDate);
    }
    map['is_visited'] = Variable<bool>(isVisited);
    if (!nullToAbsent || distance != null) {
      map['distance'] = Variable<double?>(distance);
    }
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      id: Value(id),
      lat: Value(lat),
      lng: Value(lng),
      name: Value(name),
      urls: Value(urls),
      placeType: Value(placeType),
      description: Value(description),
      plannedDate: plannedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedDate),
      isVisited: Value(isVisited),
      distance: distance == null && nullToAbsent
          ? const Value.absent()
          : Value(distance),
    );
  }

  factory Favorite.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorite(
      id: serializer.fromJson<int>(json['id']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
      name: serializer.fromJson<String>(json['name']),
      urls: serializer.fromJson<String>(json['urls']),
      placeType: serializer.fromJson<String>(json['placeType']),
      description: serializer.fromJson<String>(json['description']),
      plannedDate: serializer.fromJson<DateTime?>(json['plannedDate']),
      isVisited: serializer.fromJson<bool>(json['isVisited']),
      distance: serializer.fromJson<double?>(json['distance']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
      'name': serializer.toJson<String>(name),
      'urls': serializer.toJson<String>(urls),
      'placeType': serializer.toJson<String>(placeType),
      'description': serializer.toJson<String>(description),
      'plannedDate': serializer.toJson<DateTime?>(plannedDate),
      'isVisited': serializer.toJson<bool>(isVisited),
      'distance': serializer.toJson<double?>(distance),
    };
  }

  Favorite copyWith(
          {int? id,
          double? lat,
          double? lng,
          String? name,
          String? urls,
          String? placeType,
          String? description,
          DateTime? plannedDate,
          bool? isVisited,
          double? distance}) =>
      Favorite(
        id: id ?? this.id,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        name: name ?? this.name,
        urls: urls ?? this.urls,
        placeType: placeType ?? this.placeType,
        description: description ?? this.description,
        plannedDate: plannedDate ?? this.plannedDate,
        isVisited: isVisited ?? this.isVisited,
        distance: distance ?? this.distance,
      );
  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('id: $id, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('name: $name, ')
          ..write('urls: $urls, ')
          ..write('placeType: $placeType, ')
          ..write('description: $description, ')
          ..write('plannedDate: $plannedDate, ')
          ..write('isVisited: $isVisited, ')
          ..write('distance: $distance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lat, lng, name, urls, placeType,
      description, plannedDate, isVisited, distance);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.id == this.id &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.name == this.name &&
          other.urls == this.urls &&
          other.placeType == this.placeType &&
          other.description == this.description &&
          other.plannedDate == this.plannedDate &&
          other.isVisited == this.isVisited &&
          other.distance == this.distance);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> id;
  final Value<double> lat;
  final Value<double> lng;
  final Value<String> name;
  final Value<String> urls;
  final Value<String> placeType;
  final Value<String> description;
  final Value<DateTime?> plannedDate;
  final Value<bool> isVisited;
  final Value<double?> distance;
  const FavoritesCompanion({
    this.id = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.name = const Value.absent(),
    this.urls = const Value.absent(),
    this.placeType = const Value.absent(),
    this.description = const Value.absent(),
    this.plannedDate = const Value.absent(),
    this.isVisited = const Value.absent(),
    this.distance = const Value.absent(),
  });
  FavoritesCompanion.insert({
    this.id = const Value.absent(),
    required double lat,
    required double lng,
    required String name,
    required String urls,
    required String placeType,
    required String description,
    this.plannedDate = const Value.absent(),
    this.isVisited = const Value.absent(),
    this.distance = const Value.absent(),
  })  : lat = Value(lat),
        lng = Value(lng),
        name = Value(name),
        urls = Value(urls),
        placeType = Value(placeType),
        description = Value(description);
  static Insertable<Favorite> custom({
    Expression<int>? id,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<String>? name,
    Expression<String>? urls,
    Expression<String>? placeType,
    Expression<String>? description,
    Expression<DateTime?>? plannedDate,
    Expression<bool>? isVisited,
    Expression<double?>? distance,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (name != null) 'name': name,
      if (urls != null) 'urls': urls,
      if (placeType != null) 'place_type': placeType,
      if (description != null) 'description': description,
      if (plannedDate != null) 'planned_date': plannedDate,
      if (isVisited != null) 'is_visited': isVisited,
      if (distance != null) 'distance': distance,
    });
  }

  FavoritesCompanion copyWith(
      {Value<int>? id,
      Value<double>? lat,
      Value<double>? lng,
      Value<String>? name,
      Value<String>? urls,
      Value<String>? placeType,
      Value<String>? description,
      Value<DateTime?>? plannedDate,
      Value<bool>? isVisited,
      Value<double?>? distance}) {
    return FavoritesCompanion(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      name: name ?? this.name,
      urls: urls ?? this.urls,
      placeType: placeType ?? this.placeType,
      description: description ?? this.description,
      plannedDate: plannedDate ?? this.plannedDate,
      isVisited: isVisited ?? this.isVisited,
      distance: distance ?? this.distance,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (urls.present) {
      map['urls'] = Variable<String>(urls.value);
    }
    if (placeType.present) {
      map['place_type'] = Variable<String>(placeType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (plannedDate.present) {
      map['planned_date'] = Variable<DateTime?>(plannedDate.value);
    }
    if (isVisited.present) {
      map['is_visited'] = Variable<bool>(isVisited.value);
    }
    if (distance.present) {
      map['distance'] = Variable<double?>(distance.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('id: $id, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('name: $name, ')
          ..write('urls: $urls, ')
          ..write('placeType: $placeType, ')
          ..write('description: $description, ')
          ..write('plannedDate: $plannedDate, ')
          ..write('isVisited: $isVisited, ')
          ..write('distance: $distance')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double?> lat = GeneratedColumn<double?>(
      'lat', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double?> lng = GeneratedColumn<double?>(
      'lng', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _urlsMeta = const VerificationMeta('urls');
  @override
  late final GeneratedColumn<String?> urls = GeneratedColumn<String?>(
      'urls', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _placeTypeMeta = const VerificationMeta('placeType');
  @override
  late final GeneratedColumn<String?> placeType = GeneratedColumn<String?>(
      'place_type', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _plannedDateMeta =
      const VerificationMeta('plannedDate');
  @override
  late final GeneratedColumn<DateTime?> plannedDate =
      GeneratedColumn<DateTime?>('planned_date', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _isVisitedMeta = const VerificationMeta('isVisited');
  @override
  late final GeneratedColumn<bool?> isVisited = GeneratedColumn<bool?>(
      'is_visited', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_visited IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _distanceMeta = const VerificationMeta('distance');
  @override
  late final GeneratedColumn<double?> distance = GeneratedColumn<double?>(
      'distance', aliasedName, true,
      type: const RealType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lat,
        lng,
        name,
        urls,
        placeType,
        description,
        plannedDate,
        isVisited,
        distance
      ];
  @override
  String get aliasedName => _alias ?? 'favorites';
  @override
  String get actualTableName => 'favorites';
  @override
  VerificationContext validateIntegrity(Insertable<Favorite> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
          _lngMeta, lng.isAcceptableOrUnknown(data['lng']!, _lngMeta));
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('urls')) {
      context.handle(
          _urlsMeta, urls.isAcceptableOrUnknown(data['urls']!, _urlsMeta));
    } else if (isInserting) {
      context.missing(_urlsMeta);
    }
    if (data.containsKey('place_type')) {
      context.handle(_placeTypeMeta,
          placeType.isAcceptableOrUnknown(data['place_type']!, _placeTypeMeta));
    } else if (isInserting) {
      context.missing(_placeTypeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('planned_date')) {
      context.handle(
          _plannedDateMeta,
          plannedDate.isAcceptableOrUnknown(
              data['planned_date']!, _plannedDateMeta));
    }
    if (data.containsKey('is_visited')) {
      context.handle(_isVisitedMeta,
          isVisited.isAcceptableOrUnknown(data['is_visited']!, _isVisitedMeta));
    }
    if (data.containsKey('distance')) {
      context.handle(_distanceMeta,
          distance.isAcceptableOrUnknown(data['distance']!, _distanceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Favorite.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class SearchQuery extends DataClass implements Insertable<SearchQuery> {
  final String queryText;
  final int timestamp;
  SearchQuery({required this.queryText, required this.timestamp});
  factory SearchQuery.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SearchQuery(
      queryText: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}query_text'])!,
      timestamp: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}timestamp'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['query_text'] = Variable<String>(queryText);
    map['timestamp'] = Variable<int>(timestamp);
    return map;
  }

  SearchQueriesCompanion toCompanion(bool nullToAbsent) {
    return SearchQueriesCompanion(
      queryText: Value(queryText),
      timestamp: Value(timestamp),
    );
  }

  factory SearchQuery.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchQuery(
      queryText: serializer.fromJson<String>(json['queryText']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'queryText': serializer.toJson<String>(queryText),
      'timestamp': serializer.toJson<int>(timestamp),
    };
  }

  SearchQuery copyWith({String? queryText, int? timestamp}) => SearchQuery(
        queryText: queryText ?? this.queryText,
        timestamp: timestamp ?? this.timestamp,
      );
  @override
  String toString() {
    return (StringBuffer('SearchQuery(')
          ..write('queryText: $queryText, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(queryText, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchQuery &&
          other.queryText == this.queryText &&
          other.timestamp == this.timestamp);
}

class SearchQueriesCompanion extends UpdateCompanion<SearchQuery> {
  final Value<String> queryText;
  final Value<int> timestamp;
  const SearchQueriesCompanion({
    this.queryText = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  SearchQueriesCompanion.insert({
    required String queryText,
    required int timestamp,
  })  : queryText = Value(queryText),
        timestamp = Value(timestamp);
  static Insertable<SearchQuery> custom({
    Expression<String>? queryText,
    Expression<int>? timestamp,
  }) {
    return RawValuesInsertable({
      if (queryText != null) 'query_text': queryText,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  SearchQueriesCompanion copyWith(
      {Value<String>? queryText, Value<int>? timestamp}) {
    return SearchQueriesCompanion(
      queryText: queryText ?? this.queryText,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (queryText.present) {
      map['query_text'] = Variable<String>(queryText.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchQueriesCompanion(')
          ..write('queryText: $queryText, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $SearchQueriesTable extends SearchQueries
    with TableInfo<$SearchQueriesTable, SearchQuery> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchQueriesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _queryTextMeta = const VerificationMeta('queryText');
  @override
  late final GeneratedColumn<String?> queryText = GeneratedColumn<String?>(
      'query_text', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<int?> timestamp = GeneratedColumn<int?>(
      'timestamp', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [queryText, timestamp];
  @override
  String get aliasedName => _alias ?? 'search_queries';
  @override
  String get actualTableName => 'search_queries';
  @override
  VerificationContext validateIntegrity(Insertable<SearchQuery> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('query_text')) {
      context.handle(_queryTextMeta,
          queryText.isAcceptableOrUnknown(data['query_text']!, _queryTextMeta));
    } else if (isInserting) {
      context.missing(_queryTextMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {queryText};
  @override
  SearchQuery map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SearchQuery.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SearchQueriesTable createAlias(String alias) {
    return $SearchQueriesTable(attachedDatabase, alias);
  }
}

abstract class _$PlacesDatabase extends GeneratedDatabase {
  _$PlacesDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  late final $SearchQueriesTable searchQueries = $SearchQueriesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [favorites, searchQueries];
}
