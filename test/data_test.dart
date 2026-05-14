import 'package:dart_newoblpredemt/dart_newoblpredemt.dart';
import 'package:test/test.dart';

void main() {
  group('Data tests', () {
    test('repair mojibake text', () {
      expect(
        repairMojibakeText('Р Р°С…РёРјРѕРІР° РЎР°РјРёСЂР° Р“СѓР»СЂСѓР·РѕРІРЅР°'),
        'Рахимова Самира Гулрузовна',
      );
      expect(repairMojibakeText('Пётр Петров'), 'Пётр Петров');
    });

    test('insert and read patient from temporary SQLite', () {
      final database = ClinicDatabase(path: ':memory:');
      final repository = PatientRepository(database.db);

      final id = repository.create(Patient(
        fullName: 'Пётр Петров',
        phone: '+79991112233',
        birthDate: '1995-04-20',
      ));

      final patient = repository.readById(id);

      expect(patient, isNotNull);
      expect(patient!.fullName, 'Пётр Петров');

      database.close();
    });

    test('insert and read service from temporary SQLite', () {
      final database = ClinicDatabase(path: ':memory:');
      final repository = ServiceRepository(database.db);

      final id = repository.create(Service(
        name: 'Анализ крови',
        price: 800,
      ));

      final service = repository.readById(id);

      expect(service, isNotNull);
      expect(service!.name, 'Анализ крови');
      expect(service.price, 800);

      database.close();
    });
  });
}
