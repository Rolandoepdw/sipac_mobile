
import 'package:sipac_mobile_4/core/data/entities/external_participant.dart';
import 'package:sqflite/sqflite.dart';

class ExternalParticipantRepository {
  final Database _database;

  ExternalParticipantRepository(this._database);

  //------------------------------- Select query -------------------------------
  Future<ExternalParticipant?> getById(int externalParticipantId) async {
    final result = await _database.query(
      'ExternalParticipant',
      where: 'externalParticipantId = ?',
      whereArgs: [externalParticipantId],
    );
    return result.isNotEmpty
        ? ExternalParticipant.fromJson(result.first)
        : null;
  }

  Future<List<ExternalParticipant>> getAll() async {
    final result = await _database
        .rawQuery("SELECT * FROM ExternalParticipant ORDER BY name");
    List<ExternalParticipant> list = result.isNotEmpty
        ? result.map((e) => ExternalParticipant.fromJson(e)).toList()
        : [];
    return list;
  }

  //------------------------------- Insert query -------------------------------
  Future<int> insert(ExternalParticipant externalParticipant) async =>
      await _database.insert(
          'ExternalParticipant', externalParticipant.toJson());

  //------------------------------- Update query -------------------------------
  Future<int> update(ExternalParticipant externalParticipant) async =>
      await _database.update(
          'ExternalParticipant', externalParticipant.toJson(),
          where: 'externalParticipantId = ?',
          whereArgs: [externalParticipant.externalParticipantId]);

  //------------------------------- Delete query -------------------------------
  Future<void> delete(int externalParticipantId) async =>
      await _database.delete(
        'ExternalParticipant',
        where: 'externalParticipantId = ?',
        whereArgs: [externalParticipantId],
      );
}
