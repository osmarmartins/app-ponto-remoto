import 'package:get/get.dart';

class PontoController extends GetxController {
  var tarefaIniciada = false.obs;
  var inicio = DateTime.now().obs;
  var fim = DateTime.now().obs;
  var intervalo = const Duration().obs;
  var tempo = const Duration().obs;
  var atividadeAtual = const Duration().obs;
}
