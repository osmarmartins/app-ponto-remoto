import 'package:ponto_remoto/src/helpers/database_helper.dart';
import 'package:ponto_remoto/src/models/usuario.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioDAO {
  Future<Database> getDB() async {
    return DatabaseHelper.getInstance().getDatabase();
  }

  Future<void> save(Usuario usuario) async {
    final db = await getDB();
    await db.delete('usuario');
    await db.insert(
      'usuario',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Usuario> find() async {
    final db = await getDB();
    final List<Map<String, dynamic>> result = await db.query('usuario');

    var lista = List.generate(
      result.length,
      (i) {
        return Usuario(
          nome: result[i]['nome'],
          projeto: result[i]['projeto'],
          tarefa: result[i]['tarefa'],
        );
      },
    );

    return lista[0];
  }
}
