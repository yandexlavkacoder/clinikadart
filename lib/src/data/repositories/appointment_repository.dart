import 'package:sqlite3/sqlite3.dart';

import '../../domain/models/models.dart';
import 'repository_helper.dart';

class AppointmentRepository {
  final Database db;

  AppointmentRepository(this.db);

  int create(Appointment appointment) {
    db.execute(
      '''
      INSERT INTO appointments
      (patient_id, doctor_id, appointment_date, reason)
      VALUES (?, ?, ?, ?)
      ''',
      [
        appointment.patientId,
        appointment.doctorId,
        appointment.appointmentDate,
        appointment.reason,
      ],
    );

    return db.lastInsertRowId;
  }

  List<Appointment> readAll() {
    final result = db.select('SELECT * FROM appointments');

    return result
        .map((row) => Appointment.fromMap(rowToMap(row)))
        .toList();
  }

  Appointment? readById(int id) {
    final result =
        db.select('SELECT * FROM appointments WHERE id = ?', [id]);

    if (result.isEmpty) return null;

    return Appointment.fromMap(rowToMap(result.first));
  }

  void update(Appointment appointment) {
    db.execute(
      '''
      UPDATE appointments
      SET patient_id = ?, doctor_id = ?, appointment_date = ?, reason = ?
      WHERE id = ?
      ''',
      [
        appointment.patientId,
        appointment.doctorId,
        appointment.appointmentDate,
        appointment.reason,
        appointment.id,
      ],
    );
  }

  void delete(int id) {
    db.execute(
      'DELETE FROM appointments WHERE id = ?',
      [id],
    );
  }
}