import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'rentease.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE bookings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        car_name TEXT NOT NULL,
        car_image TEXT NOT NULL,
        location TEXT NOT NULL,
        price INTEGER NOT NULL
      )
    ''');
  }

  static Future<void> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      final result = await db.rawQuery("PRAGMA table_info(bookings)");
      final columnNames =
      result.map((row) => row['name'] as String).toList();

      if (!columnNames.contains('car_image')) {
        await db.execute(
          'ALTER TABLE bookings ADD COLUMN car_image TEXT',
        );
      }
    }
  }



  static Future<bool> signup(
      String name, String email, String password) async {
    final database = await db;

    final existingUser = await database.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (existingUser.isNotEmpty) {
      return false;
    }

    await database.insert(
      'users',
      {
        'name': name,
        'email': email,
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm.abort,
    );

    return true;
  }

  static Future<bool> login(String email, String password) async {
    final database = await db;

    final res = await database.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
      limit: 1,
    );

    return res.isNotEmpty;
  }


  static Future<void> addBooking(Map<String, dynamic> data) async {
    final database = await db;

    await database.insert(
      'bookings',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getBookings(
      String email) async {
    final database = await db;

    return await database.query(
      'bookings',
      where: 'user_email = ?',
      whereArgs: [email],
      orderBy: 'id DESC',
    );
  }

  static Future<String> getUserName(String email) async {
    final database = await db;

    final res = await database.query(
      'users',
      columns: ['name'],
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    return res.isNotEmpty ? res.first['name'] as String : 'N/A';
  }
}
