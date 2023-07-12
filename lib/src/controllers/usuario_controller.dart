import 'package:get/get.dart';

class UsuarioController extends GetxController {
  var nome = 'Osmar'.obs;
  var projeto = 'ASERP'.obs;
  var atividade = 'Implantação TEF'.obs;

  String getDescricaoAtividade() {
    return '${projeto.value} - ${atividade.value}';
  }
}
