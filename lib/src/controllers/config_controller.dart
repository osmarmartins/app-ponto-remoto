import 'package:get/get.dart';
import 'package:ponto_remoto/src/data/config_dao.dart';

class ConfigController extends GetxController {
  var nome = ''.obs;
  var projeto = ''.obs;
  var atividade = ''.obs;

  @override
  void onInit() {
    super.onInit();
    var dao = ConfigDAO();
    dao.find().then((config) {
      nome.value = config.nome;
      projeto.value = config.projeto;
      atividade.value = config.tarefa;
    });
  }

  String getDescricaoAtividade() {
    return '${projeto.value} - ${atividade.value}';
  }
}
