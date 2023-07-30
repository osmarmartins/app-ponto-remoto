import 'package:get/get.dart';
import 'package:ponto_remoto/src/data/usuario_dao.dart';

class UsuarioController extends GetxController {
  var nome = ''.obs;
  var projeto = ''.obs;
  var atividade = ''.obs;

  @override
  void onInit() {
    super.onInit();
    var dao = UsuarioDAO();
    dao.find().then((usuario) {
      nome.value = usuario.nome;
      projeto.value = usuario.projeto;
      atividade.value = usuario.tarefa;
    });
  }

  String getDescricaoAtividade() {
    return '${projeto.value} - ${atividade.value}';
  }
}
