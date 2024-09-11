import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_ctud');
    var database = await openDatabase(path, version: 1, onCreate: _createdb);
    return database;
  }

  Future<void> _createdb(Database database, int version) async {
    await database.execute(
        '''CREATE TABLE users (id INTEGER PRIMARY KEY,name TEXT,age TEXT, phonenumber TEXT,email TEXT ,gender TEXT);''');
  }
}
