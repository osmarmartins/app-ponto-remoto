import 'package:get/get.dart';

import '../models/ponto.dart';

class RelatorioController extends GetxController {
  RxList<Ponto> pontos = <Ponto>[].obs;

  void adicionarPonto(Ponto ponto) {
    pontos.add(ponto);
  }

  void removerPonto(Ponto ponto) {
    pontos.remove(ponto);
  }
}
