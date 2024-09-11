import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class fitnesshw extends GetxController {
  static final fitnesshw instancehw = fitnesshw();

  //initialization of db
  static Database? _databasehw;

  fitnesshw();

  //chech whether it has DB
  Future<Database> get checkDBhw async {
    if (_databasehw != null) return _databasehw!;
    _databasehw = await createdatabasehw();
    return _databasehw!;
  }

  //create database if not
  Future<Database> createdatabasehw() async {
    final databpath = await getApplicationDocumentsDirectory();
    print(databpath);
    String path = join(await getDatabasesPath(), 'fitness_data_hw.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: createtablehw,
    );
  }

  //create table in db
  Future<void> createtablehw(Database db, int version) async {
    await db.execute('''
      CREATE TABLE fitness_hw_table(
      cm INTEGER PRIMARY KEY,
      height REAL,
      weight REAL
      );
      ''');
  }

  //CRUD operation
  //create method
  Future<int> insertdatahw(Map<String, dynamic> data) async {
    Database db = await instancehw.checkDBhw;
    return db.insert('fitness_hw_table', data);
  }

  //retrieve method
  Future<List<Map<String, dynamic>>> retrieve_datahw() async {
    Database db = await instancehw.checkDBhw;
    return db.query('fitness_hw_table');
  }

  //update method
  Future<int> update_datahw(int cm, Map<String, dynamic> updatedData) async {
    Database db = await instancehw.checkDBhw;
    return db.update(
      'fitness_hw_table',
      updatedData,
      where: 'cm=?',
      whereArgs: [cm],
    );
  }

  //delete method
  Future<void> delete_datahw() async {
    // Database db = await instancehw.checkDBhw;
    // return db.delete(
    //   'fitness_hw_table',
    //   // where: 'id = ?',
    //   // whereArgs: [dataId],
    // );
    final db = await _databasehw;
    await db?.delete('fitness_hw_table');
  }

  Future<Map<String, double>> getLatestBMI() async {
    final db = await instancehw.checkDBhw;
    List<Map<String, dynamic>> result =
        await db.query('bmi', orderBy: 'id DESC', limit: 1);

    if (result.isNotEmpty) {
      return {
        'height': result[0]['height'],
        'weight': result[0]['weight'],
      };
    } else {
      return {'height': 0, 'weight': 0};
    }
  }

  Future<Map<String, dynamic>> getUserById(int cm) async {
    Database db = await instancehw.checkDBhw;
    List<Map<String, dynamic>> result = await db.query(
      'fitness_hw_table',
      where: 'cm = ?',
      whereArgs: [cm],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      throw Exception('User not found');
    }
  }
}
