import 'package:test/test.dart';
import 'package:dart_newoblpredemt/dart_newoblpredemt.dart';

void main() {
  group('Domain model tests', () {
    test('Patient toMap and fromMap', () {
      final patient = Patient(
        id: 1,
        fullName: 'Иван Иванов',
        phone: '+79990000000',
        birthDate: '2000-01-01',
      );

      final map = patient.toMap();
      final restored = Patient.fromMap(map);

      expect(restored.id, 1);
      expect(restored.fullName, 'Иван Иванов');
      expect(restored.phone, '+79990000000');
      expect(restored.birthDate, '2000-01-01');
    });

    test('Service toMap and fromMap', () {
      final service = Service(
        id: 1,
        name: 'Консультация терапевта',
        price: 1500,
      );

      final map = service.toMap();
      final restored = Service.fromMap(map);

      expect(restored.id, 1);
      expect(restored.name, 'Консультация терапевта');
      expect(restored.price, 1500);
    });
  });
}