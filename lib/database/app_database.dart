import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _database;
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'careops.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE staff (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT NOT NULL,
        phone TEXT,
        email TEXT,
        certification TEXT,
        isActive INTEGER NOT NULL DEFAULT 1
      )
    ''');

    await db.insert('staff', {
      'fullName': 'John Doe',
      'phone': '555-0101',
      'email': 'john@careops.com',
      'certification': 'CNA',
      'isActive': 1,
    });
    
    await db.insert('staff', {
      'fullName': 'Sarah Smith',
      'phone': '555-0102',
      'email': 'sarah@careops.com',
      'certification': 'RN',
      'isActive': 1,
    });

    await db.insert('staff', {
      'fullName': 'Mike Johnson',
      'phone': '555-0103',
      'email': 'mike@careops.com',
      'certification': 'LPN',
      'isActive': 1,
    });
  }
}