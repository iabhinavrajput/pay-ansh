import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/my_database.db';

    // Open or create the database
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Create tables here
        db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT
          )
        ''');
      },
    );
  }
}