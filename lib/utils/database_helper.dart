import 'package:asset_tracker/models/login/login_model.dart';
import 'package:asset_tracker/resource/app_resource.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class DatabaseHelper {
  Database? _database;

  /*Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }*/
  Future<Database> get database async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, AppDatabase.database),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE ${AppDatabase.userTable}(${AppDatabase.userId} TEXT PRIMARY KEY, ${AppDatabase.email} TEXT, ${AppDatabase.token} TEXT, ${AppDatabase.name} TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        //_onUpgrade(db, oldVersion, newVersion, AppDatabase.database, AppDatabase.name, 'TEXT');
      },
      version: AppDatabase.databaseVersion,
    );
    return db;
  }

  /*Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'asset_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE login_table(id TEXT PRIMARY KEY, userId TEXT, email TEXT, token TEXT)',
        );
      },
    );
  }*/

  static final _onUpgrade = (Database db, int oldVersion, int newVersion,
      String table, String columnName, String dataType) async {
    if (oldVersion < newVersion) {
      await db.execute('ALTER TABLE $table ADD COLUMN $columnName $dataType');
    }
  };

  Future<int> insert(Map<String, dynamic> row) async {
    final db = await database;
    return await db.insert(AppDatabase.userTable, row,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> query() async {
    final db = await database;
    final data = await db.query(AppDatabase.userTable);
    print('User data $data');
    return data;
  }

  Future<List<LoginModel>> queryAll() async {
    final db = await database;
    final data = await db.query(AppDatabase.userTable);
    print('User data $data');
    List<LoginModel> login =
        data.map((item) => LoginModel.fromJson(item)).toList();
    /*data.forEach((item) {
      login.add(LoginModel(
        id: item[AppDatabase.userId] as String,
        email: item[AppDatabase.email] as String,
        token: item[AppDatabase.token] as String,
      ));
    });*/
    /*List<LoginModel> login = data.map((item) {
      return LoginModel(
        id: item['id'] as String,
        userId: item['userId'] as String,
        email: item['email'] as String,
      );
    }).toList();*/
    print('User login $login');
    return login;
  }

  Future<int> update(Map<String, dynamic> row) async {
    final db = await database;
    return await db.update(AppDatabase.userTable, row,
        where: '${AppDatabase.userId} = ?', whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(AppDatabase.userTable,
        where: '${AppDatabase.userId} = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final db = await database;
    return await db.delete(AppDatabase.userTable);
  }
}
