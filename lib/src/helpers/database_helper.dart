import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._();

  static DatabaseHelper getInstance() {
    _instance ??=
        DatabaseHelper._(); // Utilizando operador de coalescência nula
    return _instance!;
  }

  Future<Database> getDatabase() async {
    _database ??=
        await _initDatabase(); // Utilizando operador de coalescência nula
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'pontoremoto.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
        CREATE TABLE pontos (
          id INTEGER PRIMARY KEY,
          usuario TEXT,
          projeto TEXT,
          atividade TEXT,
          inicio TEXT,
          fim TEXT
        )
        ''',
        );
      },
      version: 1,
    );
    return database;
  }
}
