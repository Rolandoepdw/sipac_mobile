
import 'package:sipac_mobile_4/core/data/entities/objective.dart';
import 'package:sqflite/sqflite.dart';

class ObjectiveRepository {
  final Database _database;

  ObjectiveRepository(this._database);

  //------------------------------- Select query -------------------------------
  Future<Objective?> getById(int objectiveId) async {
    final result = await _database.query(
      'Objective',
      where: 'objectiveId = ?',
      whereArgs: [objectiveId],
    );
    return result.isNotEmpty ? Objective.fromJson(result.first) : null;
  }

  Future<List<Objective>> getAll() async {
    final result =
        await _database.rawQuery("SELECT * FROM Objective ORDER BY name");
    List<Objective> list = result.isNotEmpty
        ? result.map((e) => Objective.fromJson(e)).toList()
        : [];
    return list;
  }

  //------------------------------- Insert query -------------------------------
  Future<int> insert(Objective objective) async =>
      await _database.insert('Objective', objective.toJson());

  //------------------------------- Update query -------------------------------
  Future<int> update(Objective objective) async =>
      await _database.update('Objective', objective.toJson(),
          where: 'objectiveId = ?', whereArgs: [objective.objectiveId]);

  //------------------------------- Delete query -------------------------------
  Future<int> delete(int objectiveId) async => await _database.delete(
        'Objective',
        where: 'objectiveId = ?',
        whereArgs: [objectiveId],
      );
}
