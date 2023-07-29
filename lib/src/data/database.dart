import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/ponto.dart';

class PontoDatabase {
  Future<void> createPontoTable(Database db) async {
    await db.execute('''
      CREATE TABLE ponto(
        id INTEGER PRIMARY KEY,
        usuario TEXT,
        projeto TEXT,
        atividade TEXT,
        inicio TEXT,
        fim TEXT
      )
  ''');
  }

  Future<Database> getDatabase() async {
    var db = openDatabase(
      join(await getDatabasesPath(), 'pontoremoto.db'),
      onCreate: (db, version) {
        return createPontoTable(db);
      },
      version: 1,
    );

    // ignore: avoid_print
    print(db);

    return db;
  }

  Future<List<Ponto>> findAll(DateTime data) async {
    final db = await PontoDatabase().getDatabase();
    final List<Map<String, dynamic>> result = await db.query('ponto');
    final List<Ponto> pontos =
        result.map((e) => Ponto.fromJson(e) as Ponto).toList();
    if (pontos.isEmpty) {
      return [];
    }
    return pontos;
  }

  save(Ponto ponto) async {
    // ignore: avoid_print
    print(ponto);

    final db = await PontoDatabase().getDatabase();
    await db.insert('ponto', ponto.toJson());
  }
}
