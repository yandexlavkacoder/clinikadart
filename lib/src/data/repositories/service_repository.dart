import 'package:sqlite3/sqlite3.dart';

import '../../domain/models/models.dart';
import 'repository_helper.dart';

class ServiceRepository {
  final Database db;

  ServiceRepository(this.db);

  int create(Service service) {
    db.execute(
      'INSERT INTO services (name, price) VALUES (?, ?)',
      [service.name, service.price],
    );

    return db.lastInsertRowId;
  }

  List<Service> readAll() {
    final result = db.select('SELECT * FROM services');

    return result
        .map((row) => Service.fromMap(rowToMap(row)))
        .toList();
  }

  Service? readById(int id) {
    final result =
        db.select('SELECT * FROM services WHERE id = ?', [id]);

    if (result.isEmpty) return null;

    return Service.fromMap(rowToMap(result.first));
  }

  void update(Service service) {
    db.execute(
      '''
      UPDATE services
      SET name = ?, price = ?
      WHERE id = ?
      ''',
      [
        service.name,
        service.price,
        service.id,
      ],
    );
  }

  void delete(int id) {
    db.execute(
      'DELETE FROM services WHERE id = ?',
      [id],
    );
  }
}