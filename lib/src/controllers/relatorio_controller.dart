import 'package:get/get.dart';
import 'package:ponto_remoto/src/data/ponto_dao.dart';
import 'package:ponto_remoto/src/helpers/database_helper.dart';

import '../models/ponto.dart';

class RelatorioController extends GetxController {
  RxList<Ponto> pontos = <Ponto>[].obs;

  @override
  void onInit() {
    super.onInit();
    var pontoDao = PontoDAO();
    pontoDao.findAll().then((value) => pontos.assignAll(value));
  }

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
