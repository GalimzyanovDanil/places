import 'package:drift/drift.dart';

@DataClassName('SearchQuery')
class SearchQueries extends Table {
  TextColumn get queryText => text()();

  @override
  Set<Column> get primaryKey => {queryText};
}
