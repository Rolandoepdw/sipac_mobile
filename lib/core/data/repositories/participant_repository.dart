import 'package:sipac_mobile_4/core/data/entities/participant.dart';
import 'package:sqflite/sqflite.dart';

class ParticipantRepository {
  final Database _database;

  ParticipantRepository(this._database);

  //------------------------------- Select query -------------------------------
  Future<Participant?> getParticipantById(int participantId) async {
    final result = await _database.query(
      'Participant',
      where: 'participantId = ?',
      whereArgs: [participantId],
    );
    return result.isNotEmpty ? Participant.fromJson(result.first) : null;
  }

  Future<List<Participant>> getParticipants() async {
    final result =
        await _database.rawQuery("SELECT * FROM Participant ORDER BY name");
    List<Participant> list = result.isNotEmpty
        ? result.map((e) => Participant.fromJson(e)).toList()
        : [];
    return list;
  }

  //------------------------------- Insert query -------------------------------
  Future<int> insertParticipant(Participant participant) async =>
      await _database.insert('Participant', participant.toJson());

  //------------------------------- Update query -------------------------------
  Future<int> updateParticipant(Participant participant) async =>
      await _database.update('Participant', participant.toJson(),
          where: 'ParticipantId = ?', whereArgs: [participant.participantId]);

  //------------------------------- Delete query -------------------------------
  Future<int> deleteParticipant(int participantId) async =>
      await _database.delete(
        'Participant',
        where: 'participantId = ?',
        whereArgs: [participantId],
      );
}
