import 'package:sqlite3/sqlite3.dart';

import '../../domain/models/models.dart';

Map<String, Object?> rowToMap(Row row) {
  final map = <String, Object?>{};
  for (final key in row.keys) {
    map[key] = row[key];
  }
  return map;
}

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
    return result.map((row) => Patient.fromMap(rowToMap(row))).toList();
  }

  Patient? readById(int id) {
    final result = db.select('SELECT * FROM patients WHERE id = ?', [id]);
    if (result.isEmpty) return null;
    return Patient.fromMap(rowToMap(result.first));
  }

  void update(Patient patient) {
    db.execute(
      'UPDATE patients SET full_name = ?, phone = ?, birth_date = ? WHERE id = ?',
      [patient.fullName, patient.phone, patient.birthDate, patient.id],
    );
  }

  void delete(int id) {
    db.execute('DELETE FROM patients WHERE id = ?', [id]);
  }
}

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
    return result.map((row) => Position.fromMap(rowToMap(row))).toList();
  }

  Position? readById(int id) {
    final result = db.select('SELECT * FROM positions WHERE id = ?', [id]);
    if (result.isEmpty) return null;
    return Position.fromMap(rowToMap(result.first));
  }

  void update(Position position) {
    db.execute(
      'UPDATE positions SET title = ?, salary = ? WHERE id = ?',
      [position.title, position.salary, position.id],
    );
  }

  void delete(int id) {
    db.execute('DELETE FROM positions WHERE id = ?', [id]);
  }
}

class DoctorRepository {
  final Database db;

  DoctorRepository(this.db);

  int create(Doctor doctor) {
    db.execute(
      'INSERT INTO doctors (full_name, phone, position_id) VALUES (?, ?, ?)',
      [doctor.fullName, doctor.phone, doctor.positionId],
    );
    return db.lastInsertRowId;
  }

  List<Doctor> readAll() {
    final result = db.select('SELECT * FROM doctors');
    return result.map((row) => Doctor.fromMap(rowToMap(row))).toList();
  }

  Doctor? readById(int id) {
    final result = db.select('SELECT * FROM doctors WHERE id = ?', [id]);
    if (result.isEmpty) return null;
    return Doctor.fromMap(rowToMap(result.first));
  }

  void update(Doctor doctor) {
    db.execute(
      'UPDATE doctors SET full_name = ?, phone = ?, position_id = ? WHERE id = ?',
      [doctor.fullName, doctor.phone, doctor.positionId, doctor.id],
    );
  }

  void delete(int id) {
    db.execute('DELETE FROM doctors WHERE id = ?', [id]);
  }
}

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
    return result.map((row) => Appointment.fromMap(rowToMap(row))).toList();
  }

  Appointment? readById(int id) {
    final result = db.select('SELECT * FROM appointments WHERE id = ?', [id]);
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
    db.execute('DELETE FROM appointments WHERE id = ?', [id]);
  }
}

class MedicalCardRepository {
  final Database db;

  MedicalCardRepository(this.db);

  int create(MedicalCard card) {
    db.execute(
      '''
      INSERT INTO medical_cards 
      (patient_id, doctor_id, diagnosis, treatment) 
      VALUES (?, ?, ?, ?)
      ''',
      [card.patientId, card.doctorId, card.diagnosis, card.treatment],
    );
    return db.lastInsertRowId;
  }

  List<MedicalCard> readAll() {
    final result = db.select('SELECT * FROM medical_cards');
    return result.map((row) => MedicalCard.fromMap(rowToMap(row))).toList();
  }

  MedicalCard? readById(int id) {
    final result = db.select('SELECT * FROM medical_cards WHERE id = ?', [id]);
    if (result.isEmpty) return null;
    return MedicalCard.fromMap(rowToMap(result.first));
  }

  void update(MedicalCard card) {
    db.execute(
      '''
      UPDATE medical_cards 
      SET patient_id = ?, doctor_id = ?, diagnosis = ?, treatment = ? 
      WHERE id = ?
      ''',
      [card.patientId, card.doctorId, card.diagnosis, card.treatment, card.id],
    );
  }

  void delete(int id) {
    db.execute('DELETE FROM medical_cards WHERE id = ?', [id]);
  }
}

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
    return result.map((row) => Service.fromMap(rowToMap(row))).toList();
  }

  Service? readById(int id) {
    final result = db.select('SELECT * FROM services WHERE id = ?', [id]);
    if (result.isEmpty) return null;
    return Service.fromMap(rowToMap(result.first));
  }

  void update(Service service) {
    db.execute(
      'UPDATE services SET name = ?, price = ? WHERE id = ?',
      [service.name, service.price, service.id],
    );
  }

  void delete(int id) {
    db.execute('DELETE FROM services WHERE id = ?', [id]);
  }
}

class PaymentRepository {
  final Database db;

  PaymentRepository(this.db);

  int create(Payment payment) {
    db.execute(
      '''
      INSERT INTO payments 
      (appointment_id, service_id, amount, payment_date) 
      VALUES (?, ?, ?, ?)
      ''',
      [
        payment.appointmentId,
        payment.serviceId,
        payment.amount,
        payment.paymentDate,
      ],
    );
    return db.lastInsertRowId;
  }

  List<Payment> readAll() {
    final result = db.select('SELECT * FROM payments');
    return result.map((row) => Payment.fromMap(rowToMap(row))).toList();
  }

  Payment? readById(int id) {
    final result = db.select('SELECT * FROM payments WHERE id = ?', [id]);
    if (result.isEmpty) return null;
    return Payment.fromMap(rowToMap(result.first));
  }

  void update(Payment payment) {
    db.execute(
      '''
      UPDATE payments 
      SET appointment_id = ?, service_id = ?, amount = ?, payment_date = ? 
      WHERE id = ?
      ''',
      [
        payment.appointmentId,
        payment.serviceId,
        payment.amount,
        payment.paymentDate,
        payment.id,
      ],
    );
  }

  void delete(int id) {
    db.execute('DELETE FROM payments WHERE id = ?', [id]);
  }
}

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
    final result = db.select('SELECT * FROM doctor_schedules');
    return result.map((row) => DoctorSchedule.fromMap(rowToMap(row))).toList();
  }

  DoctorSchedule? readById(int id) {
    final result =
        db.select('SELECT * FROM doctor_schedules WHERE id = ?', [id]);
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
    db.execute('DELETE FROM doctor_schedules WHERE id = ?', [id]);
  }
}