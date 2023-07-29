import 'package:ponto_remoto/src/helpers/database_helper.dart';
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
