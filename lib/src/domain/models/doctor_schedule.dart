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