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