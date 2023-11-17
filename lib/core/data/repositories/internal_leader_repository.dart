import 'package:sipac_mobile_4/core/data/entities/internal_leader.dart';
import 'package:sqflite/sqflite.dart';

class InternalLeaderRepository {
  final Database _database;

  InternalLeaderRepository(this._database);

  //------------------------------- Select query -------------------------------
  Future<InternalLeader?> getById(int internalLeaderId) async {
    final result = await _database.query(
      'InternalLeader',
      where: 'internalLeaderId = ?',
      whereArgs: [internalLeaderId],
    );
    return result.isNotEmpty ? InternalLeader.fromJson(result.first) : null;
  }

  Future<List<InternalLeader>> getAll() async {
    final result =
        await _database.rawQuery("SELECT * FROM InternalLeader ORDER BY name");
    List<InternalLeader> list = result.isNotEmpty
        ? result.map((e) => InternalLeader.fromJson(e)).toList()
        : [];
    return list;
  }

  //------------------------------- Insert query -------------------------------
  Future<int> insert(InternalLeader internalLeader) async =>
      await _database.insert('InternalLeader', internalLeader.toJson());

  //------------------------------- Update query -------------------------------
  Future<int> update(InternalLeader internalLeader) async =>
      await _database.update('InternalLeader', internalLeader.toJson(),
          where: 'internalLeaderId = ?',
          whereArgs: [internalLeader.internalLeaderId]);

  //------------------------------- Delete query -------------------------------
  Future<int> delete(int internalLeaderId) async => await _database.delete(
        'InternalLeader',
        where: 'internalLeaderId = ?',
        whereArgs: [internalLeaderId],
      );
}
