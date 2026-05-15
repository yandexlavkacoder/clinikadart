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