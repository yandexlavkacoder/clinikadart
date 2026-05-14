class Patient {
  final int? id;
  final String fullName;
  final String phone;
  final String birthDate;

  Patient({
    this.id,
    required this.fullName,
    required this.phone,
    required this.birthDate,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'full_name': fullName,
        'phone': phone,
        'birth_date': birthDate,
      };

  factory Patient.fromMap(Map<String, Object?> map) => Patient(
        id: map['id'] as int?,
        fullName: map['full_name'] as String,
        phone: map['phone'] as String,
        birthDate: map['birth_date'] as String,
      );

  @override
  String toString() =>
      'ID: $id | ФИО: $fullName | Телефон: $phone | Дата рождения: $birthDate';
}

class Position {
  final int? id;
  final String title;
  final double salary;

  Position({
    this.id,
    required this.title,
    required this.salary,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'title': title,
        'salary': salary,
      };

  factory Position.fromMap(Map<String, Object?> map) => Position(
        id: map['id'] as int?,
        title: map['title'] as String,
        salary: (map['salary'] as num).toDouble(),
      );

  @override
  String toString() => 'ID: $id | Должность: $title | Зарплата: $salary';
}

class Doctor {
  final int? id;
  final String fullName;
  final String phone;
  final int positionId;

  Doctor({
    this.id,
    required this.fullName,
    required this.phone,
    required this.positionId,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'full_name': fullName,
        'phone': phone,
        'position_id': positionId,
      };

  factory Doctor.fromMap(Map<String, Object?> map) => Doctor(
        id: map['id'] as int?,
        fullName: map['full_name'] as String,
        phone: map['phone'] as String,
        positionId: map['position_id'] as int,
      );

  @override
  String toString() =>
      'ID: $id | Врач: $fullName | Телефон: $phone | ID должности: $positionId';
}

class Appointment {
  final int? id;
  final int patientId;
  final int doctorId;
  final String appointmentDate;
  final String reason;

  Appointment({
    this.id,
    required this.patientId,
    required this.doctorId,
    required this.appointmentDate,
    required this.reason,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'patient_id': patientId,
        'doctor_id': doctorId,
        'appointment_date': appointmentDate,
        'reason': reason,
      };

  factory Appointment.fromMap(Map<String, Object?> map) => Appointment(
        id: map['id'] as int?,
        patientId: map['patient_id'] as int,
        doctorId: map['doctor_id'] as int,
        appointmentDate: map['appointment_date'] as String,
        reason: map['reason'] as String,
      );

  @override
  String toString() =>
      'ID: $id | Пациент ID: $patientId | Врач ID: $doctorId | Дата: $appointmentDate | Причина: $reason';
}

class MedicalCard {
  final int? id;
  final int patientId;
  final int doctorId;
  final String diagnosis;
  final String treatment;

  MedicalCard({
    this.id,
    required this.patientId,
    required this.doctorId,
    required this.diagnosis,
    required this.treatment,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'patient_id': patientId,
        'doctor_id': doctorId,
        'diagnosis': diagnosis,
        'treatment': treatment,
      };

  factory MedicalCard.fromMap(Map<String, Object?> map) => MedicalCard(
        id: map['id'] as int?,
        patientId: map['patient_id'] as int,
        doctorId: map['doctor_id'] as int,
        diagnosis: map['diagnosis'] as String,
        treatment: map['treatment'] as String,
      );

  @override
  String toString() =>
      'ID: $id | Пациент ID: $patientId | Врач ID: $doctorId | Диагноз: $diagnosis | Лечение: $treatment';
}

class Service {
  final int? id;
  final String name;
  final double price;

  Service({
    this.id,
    required this.name,
    required this.price,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'name': name,
        'price': price,
      };

  factory Service.fromMap(Map<String, Object?> map) => Service(
        id: map['id'] as int?,
        name: map['name'] as String,
        price: (map['price'] as num).toDouble(),
      );

  @override
  String toString() => 'ID: $id | Услуга: $name | Цена: $price';
}

class Payment {
  final int? id;
  final int appointmentId;
  final int serviceId;
  final double amount;
  final String paymentDate;

  Payment({
    this.id,
    required this.appointmentId,
    required this.serviceId,
    required this.amount,
    required this.paymentDate,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'appointment_id': appointmentId,
        'service_id': serviceId,
        'amount': amount,
        'payment_date': paymentDate,
      };

  factory Payment.fromMap(Map<String, Object?> map) => Payment(
        id: map['id'] as int?,
        appointmentId: map['appointment_id'] as int,
        serviceId: map['service_id'] as int,
        amount: (map['amount'] as num).toDouble(),
        paymentDate: map['payment_date'] as String,
      );

  @override
  String toString() =>
      'ID: $id | Запись ID: $appointmentId | Услуга ID: $serviceId | Сумма: $amount | Дата оплаты: $paymentDate';
}

class DoctorSchedule {
  final int? id;
  final int doctorId;
  final String workDate;
  final String startTime;
  final String endTime;

  DoctorSchedule({
    this.id,
    required this.doctorId,
    required this.workDate,
    required this.startTime,
    required this.endTime,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'doctor_id': doctorId,
        'work_date': workDate,
        'start_time': startTime,
        'end_time': endTime,
      };

  factory DoctorSchedule.fromMap(Map<String, Object?> map) => DoctorSchedule(
        id: map['id'] as int?,
        doctorId: map['doctor_id'] as int,
        workDate: map['work_date'] as String,
        startTime: map['start_time'] as String,
        endTime: map['end_time'] as String,
      );

  @override
  String toString() =>
      'ID: $id | Врач ID: $doctorId | Дата: $workDate | Начало: $startTime | Конец: $endTime';
}
