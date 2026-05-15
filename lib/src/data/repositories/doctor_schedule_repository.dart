import 'package:sqlite3/sqlite3.dart';

import '../../domain/models/models.dart';
import 'repository_helper.dart';

class DoctorScheduleRepository {
  final Database db;

  DoctorScheduleRepository(this.db);

  int create(DoctorSchedule schedule) {
    db.execute(
      '''
      INSERT INTO doctor_schedules
      (doctor_id, work_date, start_time, end_time)
      VALUES (?, ?, ?, ?)
      ''',
      [
        schedule.doctorId,
        schedule.workDate,
        schedule.startTime,
        schedule.endTime,
      ],
    );

    return db.lastInsertRowId;
  }

  List<DoctorSchedule> readAll() {
    final result =
        db.select('SELECT * FROM doctor_schedules');

    return result
        .map((row) => DoctorSchedule.fromMap(rowToMap(row)))
        .toList();
  }

  DoctorSchedule? readById(int id) {
    final result = db.select(
      'SELECT * FROM doctor_schedules WHERE id = ?',
      [id],
    );

    if (result.isEmpty) return null;

    return DoctorSchedule.fromMap(rowToMap(result.first));
  }

  void update(DoctorSchedule schedule) {
    db.execute(
      '''
      UPDATE doctor_schedules
      SET doctor_id = ?, work_date = ?, start_time = ?, end_time = ?
      WHERE id = ?
      ''',
      [
        schedule.doctorId,
        schedule.workDate,
        schedule.startTime,
        schedule.endTime,
        schedule.id,
      ],
    );
  }

  void delete(int id) {
    db.execute(
      'DELETE FROM doctor_schedules WHERE id = ?',
      [id],
    );
  }
}