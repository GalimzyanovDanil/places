import 'package:drift/drift.dart';

@DataClassName('Favorite')
class Favorites extends Table {
  @override
  Set<Column> get primaryKey => {id};

  IntColumn get id => integer()();
  RealColumn get lat => real()();
  RealColumn get lng => real()();
  TextColumn get name => text()();
  TextColumn get urls => text()();
  TextColumn get placeType => text()();
  TextColumn get description => text()();
  DateTimeColumn get plannedDate => dateTime().nullable()();
  BoolColumn get isVisited => boolean().withDefault(const Variable(false))();
  RealColumn get distance => real().nullable()();
}
