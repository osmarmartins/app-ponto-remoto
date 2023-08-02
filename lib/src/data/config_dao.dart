import 'package:ponto_remoto/src/helpers/database_helper.dart';
import 'package:ponto_remoto/src/models/config.dart';
import 'package:sqflite/sqflite.dart';

class ConfigDAO {
  Future<Database> getDB() async {
    return DatabaseHelper.getInstance().getDatabase();
  }

  Future<void> save(Config config) async {
    final db = await getDB();
    await db.delete('config');
    await db.insert(
      'config',
      config.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Config> find() async {
    final db = await getDB();
    final List<Map<String, dynamic>> result = await db.query('config');

    var lista = List.generate(
      result.length,
      (i) {
        return Config(
          nome: result[i]['nome'],
          projeto: result[i]['projeto'],
          tarefa: result[i]['tarefa'],
        );
      },
    );

    if (result.isEmpty) {
      return Config(
        nome: 'não definido',
        projeto: 'não definido',
        tarefa: 'não definida',
      );
    }

    return lista[0];
  }
}
