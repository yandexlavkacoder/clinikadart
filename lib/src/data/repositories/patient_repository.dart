import 'package:sqlite3/sqlite3.dart';

import '../../domain/models/models.dart';
import 'repository_helper.dart';

class PatientRepository {
  final Database db;

  PatientRepository(this.db);

  int create(Patient patient) {
    db.execute(
      'INSERT INTO patients (full_name, phone, birth_date) VALUES (?, ?, ?)',
      [patient.fullName, patient.phone, patient.birthDate],
    );

    return db.lastInsertRowId;
  }

  List<Patient> readAll() {
    final result = db.select('SELECT * FROM patients');

    return result
        .map((row) => Patient.fromMap(rowToMap(row)))
        .toList();
  }

  Patient? readById(int id) {
    final result =
        db.select('SELECT * FROM patients WHERE id = ?', [id]);

    if (result.isEmpty) return null;

    return Patient.fromMap(rowToMap(result.first));
  }

  void update(Patient patient) {
    db.execute(
      '''
      UPDATE patients
      SET full_name = ?, phone = ?, birth_date = ?
      WHERE id = ?
      ''',
      [
        patient.fullName,
        patient.phone,
        patient.birthDate,
        patient.id,
      ],
    );
  }

  void delete(int id) {
    db.execute(
      'DELETE FROM patients WHERE id = ?',
      [id],
    );
  }
}