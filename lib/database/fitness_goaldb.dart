import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class fitnessgoal extends GetxController {
  static final fitnessgoal instancegoal = fitnessgoal();

  //initialization of db
  static Database? _databasegoal;

  fitnessgoal();

  //chech whether it has DB
  Future<Database> get checkDBgoal async {
    if (_databasegoal != null) return _databasegoal!;
    _databasegoal = await createdatabasegoal();
    return _databasegoal!;
  }

  //create database if not
  Future<Database> createdatabasegoal() async {
    final databpath = await getApplicationDocumentsDirectory();
    print(databpath);
    String path = join(await getDatabasesPath(), 'fitness_data_goal.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: createtablegoal,
    );
  }

  //create table in db
  Future<void> createtablegoal(Database db, int version) async {
    await db.execute('''
      CREATE TABLE fitness_goal_table(
      gl INTEGER PRIMARY KEY,
      goal TEXT,
      point TEXT
      );
      ''');
  }

  //CRUD operation
  //create method
  Future<int> insertdatagoal(Map<String, dynamic> data) async {
    Database db = await instancegoal.checkDBgoal;
    return db.insert('fitness_goal_table', data);
  }

  //retrieve method
  Future<List<Map<String, dynamic>>> retrieve_datagoal() async {
    Database db = await instancegoal.checkDBgoal;
    return db.query('fitness_goal_table');
  }

  //update method
  Future<int> update_datagoal(int gl, Map<String, dynamic> updatedData) async {
    Database db = await instancegoal.checkDBgoal;
    return db.update(
      'FITNESS_goal_table',
      updatedData,
      where: 'gl=?',
      whereArgs: [gl],
    );
  }

  //delete method
  Future<void> delete_datagoal() async {
    //Database db = await instancegoal.checkDBgoal;
    final db = await _databasegoal;
    await db?.delete('fitness_goal_table');
    // return db.delete(
    //   'fitness_goal_table',
    // where: 'id = ?',
    // whereArgs: [dataId],
    //);
  }

  Future<Map<String, dynamic>> getUserById(int gl) async {
    Database db = await instancegoal.checkDBgoal;
    List<Map<String, dynamic>> result = await db.query(
      'FITNESS_goal_table',
      where: 'gl = ?',
      whereArgs: [gl],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      throw Exception('User not found');
    }
  }
}
