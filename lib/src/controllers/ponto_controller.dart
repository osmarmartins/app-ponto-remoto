import 'package:get/get.dart';

class PontoController extends GetxController {
  var tarefaIniciada = false.obs;
  var inicio = DateTime.now().obs;
  var fim = DateTime.now().obs;

  setTarefaIniciada(bool value) => tarefaIniciada.value = value;
  setInicio(var value) => inicio.value = value;
  setFim(var value) => fim.value = value;
}
