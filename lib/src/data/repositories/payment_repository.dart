import 'package:sqlite3/sqlite3.dart';

import '../../domain/models/models.dart';
import 'repository_helper.dart';

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

    return result
        .map((row) => Payment.fromMap(rowToMap(row)))
        .toList();
  }

  Payment? readById(int id) {
    final result =
        db.select('SELECT * FROM payments WHERE id = ?', [id]);

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
    db.execute(
      'DELETE FROM payments WHERE id = ?',
      [id],
    );
  }
}