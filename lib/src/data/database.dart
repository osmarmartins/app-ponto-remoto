import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/ponto.dart';

class PontoDatabase {
  Future<Database> getDB() async {
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

  Future<void> save(Ponto ponto) async {
    final db = await getDB();
    await db.insert(
      'pontos',
      ponto.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Ponto>> findAll() async {
    final db = await getDB();
    final List<Map<String, dynamic>> result = await db.query('pontos');
    var lista = List.generate(result.length, (i) {
      return Ponto(
        usuario: result[i]['usuario'],
        projeto: result[i]['projeto'],
        atividade: result[i]['atividade'],
        inicio: DateTime.parse(result[i]['inicio']),
        fim: DateTime.parse(result[i]['fim']),
      );
    });

    lista.forEach((e) {
      print('${e.projeto} - ${e.atividade} - ${e.inicio}');
    });

    return lista;
  }
}
