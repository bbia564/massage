import 'package:get/get.dart';
import 'package:my_massage/db_massage/massage_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBMassage extends GetxService {
  late Database dbBase;

  Future<DBMassage> init() async {
    await createMassageDB();
    return this;
  }

  createMassageDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'massage.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createMassageTable(db);
        });
  }

  createMassageTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS massage (id INTEGER PRIMARY KEY, createdTime TEXT, useTime TEXT)');
  }

  insertMassageData(MassageEntity pullEntity) async {
    final id = await dbBase.insert('massage', {
      'createdTime': pullEntity.createdTime.toIso8601String(),
      'useTime': pullEntity.useTime,
    });
    return id;
  }

  cleanMassageData() async {
    await dbBase.delete('massage');
  }

  Future<List<MassageEntity>> getMassageAllData() async {
    var result = await dbBase.query('massage', orderBy: 'createdTime DESC');
    return result.map((e) => MassageEntity.fromJson(e)).toList();
  }
}
