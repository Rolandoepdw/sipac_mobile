import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static Database? _database;

  static final DB db = DB._();

  DB._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'SIPACDB.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      //------------------------------- entities -------------------------------
      await db.execute('CREATE TABLE Activity ('
          ' activityId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
          ' activityColor INTEGER,'
          ' generalActivityId INTEGER,'
          ' denomination TEXT NOT NULL,'
          ' startDate TEXT NOT NULL,'
          ' endDate TEXT NOT NULL,'
          ' place TEXT NOT NULL,'
          ' strategy INTEGER NOT NULL,'
          ' internalLeader INTEGER,'
          ' externalLeader TEXT,'
          ' videoConference INTEGER,'
          ' controlActivity INTEGER,'
          ' punctuated INTEGER,'
          ' extraPlan INTEGER,'
          ' meeting INTEGER'
          ')');
      await db.execute('CREATE TABLE Strategy ('
          ' strategyId INTEGER PRIMARY KEY NOT NULL,'
          ' name TEXT NOT NULL'
          ')');
      await db.execute('CREATE TABLE InternalLeader ('
          ' internalLeaderId INTEGER PRIMARY KEY NOT NULL,'
          ' name TEXT'
          ')');
      await db.execute('CREATE TABLE Objective ('
          ' objectiveId INTEGER PRIMARY KEY NOT NULL,'
          ' name TEXT NOT NULL'
          ')');
      await db.execute('CREATE TABLE Process ('
          ' processId INTEGER PRIMARY KEY NOT NULL,'
          ' name TEXT NOT NULL'
          ')');
      await db.execute('CREATE TABLE Participant ('
          ' participantId INTEGER PRIMARY KEY NOT NULL,'
          ' name TEXT NOT NULL'
          ')');
      await db.execute('CREATE TABLE ExternalParticipant ('
          ' externalParticipantId INTEGER PRIMARY KEY NOT NULL,'
          ' name TEXT NOT NULL'
          ')');
      //---------------------------------- m-m ---------------------------------
      await db.execute('CREATE TABLE ActivityObjective ('
          ' activityId INTEGER NOT NULL,'
          ' objectiveId INTEGER NOT NULL'
          ')');
      await db.execute('CREATE TABLE ActivityProcess ('
          ' activityId INTEGER NOT NULL,'
          ' processId INTEGER NOT NULL'
          ')');
      await db.execute('CREATE TABLE ActivityParticipant ('
          ' activityId INTEGER NOT NULL,'
          ' participantId INTEGER NULL'
          ')');
      await db.execute('CREATE TABLE ActivityExternalParticipant ('
          ' activityId INTEGER NOT NULL,'
          ' externalParticipantId INTEGER NOT NULL'
          ')');
    });
  }


// //---------------------------------- Utils -------------------------------------
//
//   Future<int?> checkClientExistence(String search) async {
//     Database? db = await database;
//     final result = await db
//         ?.rawQuery("SELECT * FROM Client WHERE Client.name LIKE '%$search%'");
//     return result?.length;
//   }
//
//   Future<int?> getClientLength() async {
//     Database? db = await database;
//     return Sqflite.firstIntValue(
//         await db!.rawQuery('SELECT COUNT(*) FROM Client'));
//   }
//
//   Future<List<Client>> getClientSearch(String search) async {
//     Database? db = await database;
//     final result = await db
//         ?.rawQuery("SELECT * FROM Client WHERE Client.name LIKE '%$search%'");
//     List<Client> list = result!.isNotEmpty
//         ? result.map((e) => Client.fromJson(e)).toList()
//         : [];
//     return list;
//   }
//
//   Future<List<Vendor>> getVendorSearch(String search) async {
//     Database? db = await database;
//     final result = await db
//         ?.rawQuery("SELECT * FROM Vendor WHERE Vendor.name LIKE '%$search%'");
//     List<Vendor> list = result!.isNotEmpty
//         ? result.map((e) => Vendor.fromJson(e)).toList()
//         : [];
//     return list;
//   }
//
//   Future<List<Product>> getProductSearch(String search) async {
//     Database? db = await database;
//     final result = await db
//         ?.rawQuery("SELECT * FROM Product WHERE Product.name LIKE '%$search%'");
//     List<Product> list = result!.isNotEmpty
//         ? result.map((e) => Product.fromJson(e)).toList()
//         : [];
//     return list;
//   }
//
}
