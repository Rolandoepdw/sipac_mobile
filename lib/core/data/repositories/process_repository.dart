import 'package:sipac_mobile_4/core/data/entities/process.dart';
import 'package:sqflite/sqflite.dart';

class ProcessRepository {
  final Database _database;

  ProcessRepository(this._database);

  //------------------------------- Select query -------------------------------
  Future<Process?> getById(int processId) async {
    final result = await _database.query(
      'Process',
      where: 'processId = ?',
      whereArgs: [processId],
    );
    return result.isNotEmpty ? Process.fromJson(result.first) : null;
  }

  Future<List<Process>> getAll() async {
    final result =
        await _database.rawQuery("SELECT * FROM Process ORDER BY name");
    List<Process> list = result.isNotEmpty
        ? result.map((e) => Process.fromJson(e)).toList()
        : [];
    return list;
  }

  //------------------------------- Insert query -------------------------------
  Future<int> insert(Process process) async =>
      await _database.insert('Process', process.toJson());

  //------------------------------- Update query -------------------------------
  Future<int> update(Process process) async =>
      await _database.update('Process', process.toJson(),
          where: 'processId = ?', whereArgs: [process.processId]);

  //------------------------------- Delete query -------------------------------
  Future<int> delete(int processId) async => await _database.delete(
        'Process',
        where: 'processId = ?',
        whereArgs: [processId],
      );
}
