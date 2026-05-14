import 'package:test/test.dart';
import 'package:dart_newoblpredemt/dart_newoblpredemt.dart';

void main() {
  group('Validation tests', () {
    test('required text valid', () {
      expect(validateRequiredText('Иван'), isNull);
    });

    test('required text invalid', () {
      expect(validateRequiredText('   '), isNotNull);
    });

    test('positive number valid', () {
      expect(validatePositiveNumber(10), isNull);
    });

    test('positive number invalid', () {
      expect(validatePositiveNumber(0), isNotNull);
    });

    test('date valid', () {
      expect(validateDate('2026-05-14'), isNull);
    });

    test('date invalid', () {
      expect(validateDate('wrong date'), isNotNull);
    });
  });
}