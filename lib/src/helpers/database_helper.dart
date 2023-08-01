import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._();

  static DatabaseHelper getInstance() {
    _instance ??= DatabaseHelper._();
    return _instance!;
  }

  Future<Database> getDatabase() async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'pontoremoto.db'),
      onCreate: (db, version) {
        _createTableUsuario(db);
        _createTablePontos(db);
      },
      version: 1,
    );
    return database;
  }

  void _createTablePontos(Database db) async {
    await db.execute('''
    CREATE TABLE pontos (
      id INTEGER PRIMARY KEY,
      usuario TEXT,
      projeto TEXT,
      atividade TEXT,
      inicio TEXT,
      fim TEXT
    )
  ''');
  }

  void _createTableUsuario(Database db) async {
    await db.execute('''
        CREATE TABLE config (
          id INTEGER PRIMARY KEY,
          nome TEXT,
          projeto TEXT,
          tarefa TEXT
        )
  ''');
  }
}
