

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