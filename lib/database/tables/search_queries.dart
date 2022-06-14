import 'package:drift/drift.dart';

@DataClassName('SearchQuery')
class SearchQueries extends Table {
  TextColumn get queryText => text()();
  IntColumn get timestamp => integer()();

  @override
  Set<Column> get primaryKey => {queryText};
}
