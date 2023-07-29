import 'package:get/get.dart';

import '../models/ponto.dart';

class RelatorioController extends GetxController {
  RxList<Ponto> pontos = <Ponto>[].obs;

  set items(List<Ponto> items) {
    pontos.assignAll(items);
  }

  void adicionarPonto(Ponto ponto) {
    pontos.add(ponto);
  }

  Duration tempoTotal() {
    return pontos.isEmpty
        ? Duration.zero
        : pontos
            .map((ponto) => ponto.tempo())
            .reduce((acc, tempo) => acc + tempo);
  }
}
