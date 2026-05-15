import 'package:sqlite3/sqlite3.dart';

import '../../domain/models/models.dart';
import 'repository_helper.dart';

class DoctorRepository {
  final Database db;

  DoctorRepository(this.db);

  int create(Doctor doctor) {
    db.execute(
      '''
      INSERT INTO doctors
      (full_name, phone, position_id)
      VALUES (?, ?, ?)
      ''',
      [
        doctor.fullName,
        doctor.phone,
        doctor.positionId,
      ],
    );

    return db.lastInsertRowId;
  }

  List<Doctor> readAll() {
    final result = db.select('SELECT * FROM doctors');

    return result
        .map((row) => Doctor.fromMap(rowToMap(row)))
        .toList();
  }

  Doctor? readById(int id) {
    final result =
        db.select('SELECT * FROM doctors WHERE id = ?', [id]);

    if (result.isEmpty) return null;

    return Doctor.fromMap(rowToMap(result.first));
  }

  void update(Doctor doctor) {
    db.execute(
      '''
      UPDATE doctors
      SET full_name = ?, phone = ?, position_id = ?
      WHERE id = ?
      ''',
      [
        doctor.fullName,
        doctor.phone,
        doctor.positionId,
        doctor.id,
      ],
    );
  }

  void delete(int id) {
    db.execute(
      'DELETE FROM doctors WHERE id = ?',
      [id],
    );
  }
}