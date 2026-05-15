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