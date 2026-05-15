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