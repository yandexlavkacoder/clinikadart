import 'package:sqlite3/sqlite3.dart';

import '../../domain/models/models.dart';
import 'repository_helper.dart';

class MedicalCardRepository {
  final Database db;

  MedicalCardRepository(this.db);

  int create(MedicalCard card) {
    db.execute(
      '''
      INSERT INTO medical_cards
      (patient_id, doctor_id, diagnosis, treatment)
      VALUES (?, ?, ?, ?)
      ''',
      [
        card.patientId,
        card.doctorId,
        card.diagnosis,
        card.treatment,
      ],
    );

    return db.lastInsertRowId;
  }

  List<MedicalCard> readAll() {
    final result = db.select('SELECT * FROM medical_cards');

    return result
        .map((row) => MedicalCard.fromMap(rowToMap(row)))
        .toList();
  }

  MedicalCard? readById(int id) {
    final result =
        db.select('SELECT * FROM medical_cards WHERE id = ?', [id]);

    if (result.isEmpty) return null;

    return MedicalCard.fromMap(rowToMap(result.first));
  }

  void update(MedicalCard card) {
    db.execute(
      '''
      UPDATE medical_cards
      SET patient_id = ?, doctor_id = ?, diagnosis = ?, treatment = ?
      WHERE id = ?
      ''',
      [
        card.patientId,
        card.doctorId,
        card.diagnosis,
        card.treatment,
        card.id,
      ],
    );
  }

  void delete(int id) {
    db.execute(
      'DELETE FROM medical_cards WHERE id = ?',
      [id],
    );
  }
}