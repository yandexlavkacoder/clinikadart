import 'dart:convert';

import 'package:sqlite3/sqlite3.dart';

const Map<String, int> _mojibakeCp1251ByteMap = {
  '\u0420': 0xD0,
  '\u0421': 0xD1,
  '\u00A0': 0xA0,
  '\u0402': 0x80,
  '\u0403': 0x81,
  '\u201A': 0x82,
  '\u0453': 0x83,
  '\u201E': 0x84,
  '\u2026': 0x85,
  '\u2020': 0x86,
  '\u2021': 0x87,
  '\u20AC': 0x88,
  '\u2030': 0x89,
  '\u0409': 0x8A,
  '\u2039': 0x8B,
  '\u040A': 0x8C,
  '\u040C': 0x8D,
  '\u040B': 0x8E,
  '\u040F': 0x8F,
  '\u0452': 0x90,
  '\u2018': 0x91,
  '\u2019': 0x92,
  '\u201C': 0x93,
  '\u201D': 0x94,
  '\u2022': 0x95,
  '\u2013': 0x96,
  '\u2014': 0x97,
  '\u2122': 0x99,
  '\u0459': 0x9A,
  '\u203A': 0x9B,
  '\u045A': 0x9C,
  '\u045C': 0x9D,
  '\u045B': 0x9E,
  '\u045F': 0x9F,
  '\u040E': 0xA1,
  '\u045E': 0xA2,
  '\u0408': 0xA3,
  '\u00A4': 0xA4,
  '\u0490': 0xA5,
  '\u00A6': 0xA6,
  '\u00A7': 0xA7,
  '\u0401': 0xA8,
  '\u00A9': 0xA9,
  '\u0404': 0xAA,
  '\u00AB': 0xAB,
  '\u00AC': 0xAC,
  '\u00AD': 0xAD,
  '\u00AE': 0xAE,
  '\u0407': 0xAF,
  '\u00B0': 0xB0,
  '\u00B1': 0xB1,
  '\u0406': 0xB2,
  '\u0456': 0xB3,
  '\u0491': 0xB4,
  '\u00B5': 0xB5,
  '\u00B6': 0xB6,
  '\u00B7': 0xB7,
  '\u0451': 0xB8,
  '\u2116': 0xB9,
  '\u0454': 0xBA,
  '\u00BB': 0xBB,
  '\u0458': 0xBC,
  '\u0405': 0xBD,
  '\u0455': 0xBE,
  '\u0457': 0xBF,
};

const Map<String, String> _knownBrokenValues = {
  'Р Р°С…РёРјРѕРІР° РЎР°РјРёСЂР° Р“СѓР»СЂСѓР·РѕРІРЅР°':
      'Рахимова Самира Гулрузовна',
  'РЯхзлнбЯ ПЯлзрЯ ГукружнбмЯ': 'Рахимова Самира Гулрузовна',
};

final Set<String> _mojibakeContinuationChars = {
  for (final entry in _mojibakeCp1251ByteMap.entries)
    if (entry.key != '\u0420' && entry.key != '\u0421') entry.key,
};

List<int>? _encodePossibleMojibake(String value) {
  final bytes = <int>[];

  for (final rune in value.runes) {
    if (rune <= 0x7F) {
      bytes.add(rune);
      continue;
    }

    final char = String.fromCharCode(rune);
    final mappedByte = _mojibakeCp1251ByteMap[char];
    if (mappedByte == null) {
      return null;
    }

    bytes.add(mappedByte);
  }

  return bytes;
}

bool _looksLikeUtf8MojibakeInCp1251(String value) {
  if (!(value.contains('\u0420') || value.contains('\u0421'))) {
    return false;
  }

  for (final rune in value.runes) {
    if (_mojibakeContinuationChars.contains(String.fromCharCode(rune))) {
      return true;
    }
  }

  return false;
}

String repairMojibakeText(String value) {
  final knownFixedValue = _knownBrokenValues[value];
  if (knownFixedValue != null) {
    return knownFixedValue;
  }

  if (!_looksLikeUtf8MojibakeInCp1251(value)) {
    return value;
  }

  final bytes = _encodePossibleMojibake(value);
  if (bytes == null) {
    return value;
  }

  try {
    final repaired = utf8.decode(bytes);
    if (RegExp(r'[А-Яа-яЁё]').hasMatch(repaired) &&
        !_looksLikeUtf8MojibakeInCp1251(repaired)) {
      return repaired;
    }
  } on FormatException {
    return value;
  }

  return value;
}

class ClinicDatabase {
  final Database db;

  ClinicDatabase({String path = 'clinic.db'}) : db = sqlite3.open(path) {
    db.execute('PRAGMA foreign_keys = ON;');
    createTables();
    repairStoredTextEncoding();
  }

  void createTables() {
    db.execute('''
      CREATE TABLE IF NOT EXISTS patients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT NOT NULL,
        phone TEXT NOT NULL,
        birth_date TEXT NOT NULL
      );
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS positions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        salary REAL NOT NULL
      );
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS doctors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT NOT NULL,
        phone TEXT NOT NULL,
        position_id INTEGER NOT NULL,
        FOREIGN KEY (position_id) REFERENCES positions(id)
      );
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS appointments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        patient_id INTEGER NOT NULL,
        doctor_id INTEGER NOT NULL,
        appointment_date TEXT NOT NULL,
        reason TEXT NOT NULL,
        FOREIGN KEY (patient_id) REFERENCES patients(id),
        FOREIGN KEY (doctor_id) REFERENCES doctors(id)
      );
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS medical_cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        patient_id INTEGER NOT NULL,
        doctor_id INTEGER NOT NULL,
        diagnosis TEXT NOT NULL,
        treatment TEXT NOT NULL,
        FOREIGN KEY (patient_id) REFERENCES patients(id),
        FOREIGN KEY (doctor_id) REFERENCES doctors(id)
      );
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS services (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL
      );
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS payments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        appointment_id INTEGER NOT NULL,
        service_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        payment_date TEXT NOT NULL,
        FOREIGN KEY (appointment_id) REFERENCES appointments(id),
        FOREIGN KEY (service_id) REFERENCES services(id)
      );
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS doctor_schedules (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        doctor_id INTEGER NOT NULL,
        work_date TEXT NOT NULL,
        start_time TEXT NOT NULL,
        end_time TEXT NOT NULL,
        FOREIGN KEY (doctor_id) REFERENCES doctors(id)
      );
    ''');
  }

  void repairStoredTextEncoding() {
    final textColumnsByTable = <String, List<String>>{
      'patients': ['full_name', 'phone', 'birth_date'],
      'positions': ['title'],
      'doctors': ['full_name', 'phone'],
      'appointments': ['appointment_date', 'reason'],
      'medical_cards': ['diagnosis', 'treatment'],
      'services': ['name'],
      'payments': ['payment_date'],
      'doctor_schedules': ['work_date', 'start_time', 'end_time'],
    };

    for (final entry in textColumnsByTable.entries) {
      final table = entry.key;
      final columns = entry.value;
      final rows = db.select('SELECT id, ${columns.join(', ')} FROM $table');

      for (final row in rows) {
        final updates = <String, String>{};

        for (final column in columns) {
          final value = row[column];
          if (value is! String) continue;

          final repaired = repairMojibakeText(value);
          if (repaired != value) {
            updates[column] = repaired;
          }
        }

        if (updates.isEmpty) continue;

        final setClause = updates.keys.map((column) => '$column = ?').join(', ');
        final params = [...updates.values, row['id']];
        db.execute('UPDATE $table SET $setClause WHERE id = ?', params);
      }
    }
  }

  void close() {
    db.dispose();
  }
}
