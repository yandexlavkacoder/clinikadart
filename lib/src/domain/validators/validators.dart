String? validateRequiredText(String value) {
  if (value.trim().isEmpty) {
    return 'Поле не может быть пустым';
  }
  return null;
}

String? validatePositiveNumber(num value) {
  if (value <= 0) {
    return 'Число должно быть больше 0';
  }
  return null;
}

String? validateDate(String value) {
  if (DateTime.tryParse(value.trim()) == null) {
    return 'Дата должна быть в формате YYYY-MM-DD';
  }
  return null;
}
