import 'dart:convert';
import 'dart:io';

import '../domain/validators/validators.dart';

class InputHelper {
  String askString(String message) {
    while (true) {
      stdout.write(message);
      final value = stdin.readLineSync(encoding: utf8) ?? '';

      final error = validateRequiredText(value);
      if (error == null) return value.trim();

      print('Ошибка: $error');
    }
  }

  int askInt(String message) {
    while (true) {
      stdout.write(message);
      final value = stdin.readLineSync(encoding: utf8) ?? '';
      final number = int.tryParse(value);

      if (number != null && validatePositiveNumber(number) == null) {
        return number;
      }

      print('Ошибка: введите целое число больше 0');
    }
  }

  double askDouble(String message) {
    while (true) {
      stdout.write(message);
      final value = stdin.readLineSync(encoding: utf8) ?? '';
      final number = double.tryParse(value);

      if (number != null && validatePositiveNumber(number) == null) {
        return number;
      }

      print('Ошибка: введите число больше 0');
    }
  }

  String askDate(String message) {
    while (true) {
      stdout.write(message);
      final value = stdin.readLineSync(encoding: utf8) ?? '';

      final error = validateDate(value);
      if (error == null) return value.trim();

      print('Ошибка: $error');
    }
  }
}
