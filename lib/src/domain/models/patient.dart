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