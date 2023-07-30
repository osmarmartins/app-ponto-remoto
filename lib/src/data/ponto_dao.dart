import 'package:ponto_remoto/src/helpers/database_helper.dart';
import 'package:ponto_remoto/src/helpers/date_time_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../models/ponto.dart';

class PontoDAO {
  Future<Database> getDB() async {
    return DatabaseHelper.getInstance().getDatabase();
  }

  Future<void> save(Ponto ponto) async {
    final db = await getDB();
    await db.insert(
      'pontos',
      ponto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Ponto>> findAll(DateTime data) async {
    var arg = '${DateTimeHelper.formatarDataSQL(data)}%';
    final db = await getDB();
    final List<Map<String, dynamic>> result = await db.query(
      'pontos',
      columns: ['*'],
      where: 'inicio like ?',
      whereArgs: [arg],
    );

    var lista = List.generate(result.length, (i) {
      return Ponto(
        usuario: result[i]['usuario'],
        projeto: result[i]['projeto'],
        atividade: result[i]['atividade'],
        inicio: DateTime.parse(result[i]['inicio']),
        fim: DateTime.parse(result[i]['fim']),
      );
    });

    return lista;
  }
}
