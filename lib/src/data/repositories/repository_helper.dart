import 'package:sqlite3/sqlite3.dart';

Map<String, Object?> rowToMap(Row row) {
  final map = <String, Object?>{};

  for (final key in row.keys) {
    map[key] = row[key];
  }

  return map;
}