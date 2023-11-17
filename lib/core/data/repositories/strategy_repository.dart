import 'package:sipac_mobile_4/core/data/entities/strategy.dart';
import 'package:sqflite/sqflite.dart';

class StrategyRepository {
  final Database _database;

  StrategyRepository(this._database);

  //------------------------------- Select query -------------------------------
  Future<Strategy?> getById(int strategyId) async {
    final result = await _database.query(
      'Strategy',
      where: 'strategyId = ?',
      whereArgs: [strategyId],
    );
    return result.isNotEmpty ? Strategy.fromJson(result.first) : null;
  }

  Future<List<Strategy>> getAll() async {
    final result =
        await _database.rawQuery("SELECT * FROM Strategy ORDER BY name");
    List<Strategy> list = result.isNotEmpty
        ? result.map((e) => Strategy.fromJson(e)).toList()
        : [];
    return list;
  }

  //------------------------------- Insert query -------------------------------
  Future<int> insert(Strategy strategy) async =>
      await _database.insert('Strategy', strategy.toJson());

  //------------------------------- Update query -------------------------------
  Future<int> update(Strategy strategy) async =>
      await _database.update('Strategy', strategy.toJson(),
          where: 'strategyId = ?', whereArgs: [strategy.strategyId]);

  //------------------------------- Delete query -------------------------------
  Future<int> delete(int strategyId) async => await _database.delete(
        'Strategy',
        where: 'strategyId = ?',
        whereArgs: [strategyId],
      );
}
