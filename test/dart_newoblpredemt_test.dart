import 'package:dart_newoblpredemt/dart_newoblpredemt.dart';
import 'package:test/test.dart';

void main() {
  test('package exports menu and validators', () {
    expect(Menu, isNotNull);
    expect(validateRequiredText('тест'), isNull);
  });
}
