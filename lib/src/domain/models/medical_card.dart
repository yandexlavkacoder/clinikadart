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