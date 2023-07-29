import 'package:get/get.dart';

class UsuarioController extends GetxController {
  var nome = ''.obs;
  var projeto = ''.obs;
  var atividade = ''.obs;

  String getDescricaoAtividade() {
    return '${projeto.value} - ${atividade.value}';
  }
}
