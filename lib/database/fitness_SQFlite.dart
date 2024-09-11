//import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class fitnessDBSQFlite extends GetxController {
  static final fitnessDBSQFlite instance = fitnessDBSQFlite._internal();

  factory fitnessDBSQFlite() {
    return instance;
  }

  //initialization of DB]
  fitnessDBSQFlite._internal();
  static Database? _database;

  //check whether it has DB
  Future<Database> get checkDB async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  //create DB if not
  Future<Database> createDatabase() async {
    final dbpath =
        await getApplicationDocumentsDirectory(); //document directory finding
    print(dbpath);
    String path = join(await getDatabasesPath(),
        'fitness_data.db'); //joining the path with the database name
    return await openDatabase(
      path,
      version: 1,
      onCreate: createtable,
    );
  }

  //create table for db
  Future<void> createtable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE FITNESS_table(
        id INTEGER PRIMARY KEY, 
        user_name TEXT,
        age TEXT,
        phone_number TEXT,
        E_MAIL TEXT,
        gender TEXT
      );
      ''');
  }

  //CRUD operation
  //create method
  Future<int> insertdata(Map<String, dynamic> data) async {
    Database db = await instance.checkDB;
    return db.insert('FITNESS_table', data);
  }

  //retrieve method
  Future<List<Map<String, dynamic>>> retrieve_data() async {
    Database db = await instance.checkDB;
    return db.query('Fitness_table');
  }

  //update method
  Future<int> update_data(int ID, Map<String, dynamic> updatedData) async {
    Database db = await instance.checkDB;
    return db.update(
      'FITNESS_table',
      updatedData,
      where: 'id=?',
      whereArgs: [ID],
    );
  }

  //delete method
  Future<void> delete_data() async {
    // Database db = await instance.checkDB;
    // return db.delete(
    //   'FITNESS_TABLE',
    //   // where:'id = ?' ,
    //   // whereArgs: [dataId],
    // );
    final db = await _database;
    await db?.delete('FITNESS_table');
  }

  // Get user by ID method
  Future<Map<String, dynamic>> getUserById(int id) async {
    Database db = await instance.checkDB;
    List<Map<String, dynamic>> result = await db.query(
      'FITNESS_table',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      throw Exception('User not found');
    }
  }
}
