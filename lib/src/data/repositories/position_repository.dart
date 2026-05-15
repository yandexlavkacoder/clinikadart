import 'package:sqlite3/sqlite3.dart';

import '../../domain/models/models.dart';
import 'repository_helper.dart';

class PositionRepository {
  final Database db;

  PositionRepository(this.db);

  int create(Position position) {
    db.execute(
      'INSERT INTO positions (title, salary) VALUES (?, ?)',
      [position.title, position.salary],
    );

    return db.lastInsertRowId;
  }

  List<Position> readAll() {
    final result = db.select('SELECT * FROM positions');

    return result
        .map((row) => Position.fromMap(rowToMap(row)))
        .toList();
  }

  Position? readById(int id) {
    final result =
        db.select('SELECT * FROM positions WHERE id = ?', [id]);

    if (result.isEmpty) return null;

    return Position.fromMap(rowToMap(result.first));
  }

  void update(Position position) {
    db.execute(
      '''
      UPDATE positions
      SET title = ?, salary = ?
      WHERE id = ?
      ''',
      [
        position.title,
        position.salary,
        position.id,
      ],
    );
  }

  void delete(int id) {
    db.execute(
      'DELETE FROM positions WHERE id = ?',
      [id],
    );
  }
}