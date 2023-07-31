import 'package:get/get.dart';
import 'package:ponto_remoto/src/controllers/relatorio_controller.dart';
import 'package:ponto_remoto/src/controllers/usuario_controller.dart';
import 'package:ponto_remoto/src/data/ponto_dao.dart';
import 'package:ponto_remoto/src/models/ponto.dart';

class PontoController extends GetxController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UsuarioController());
    Get.lazyPut(() => RelatorioController());
  }

  @override
  void onClose() {
    // TODO Finalizar "ponto" de forma automática ao destruir APP (não funciona)
    finalizarPonto();
    print('FINALIZANDO PROCESSO....');
    super.onClose();
  }

  var tarefaIniciada = false.obs;
  var inicio = DateTime.now().obs;
  var fim = DateTime.now().obs;
  var intervalo = const Duration().obs;
  var tempo = const Duration().obs;
  var atividadeAtual = const Duration().obs;

  var dao = PontoDAO();
  var usuarioController = Get.put(UsuarioController());
  var relatorioController = Get.put(RelatorioController());

  void iniciarPonto() {
    intervalo.value = fim.value.difference(inicio.value);
    atividadeAtual.value = const Duration(seconds: 0, minutes: 0, hours: 0);
    inicio.value = DateTime.now();
    fim.value = DateTime.now();
    tarefaIniciada.value = true;
  }

  void finalizarPonto() async {
    fim.value = DateTime.now();
    intervalo.value = fim.value.difference(inicio.value);
    tempo.value += intervalo.value;
    tarefaIniciada.value = false;

    await dao.save(Ponto(
        usuario: usuarioController.nome.value,
        projeto: usuarioController.projeto.value,
        atividade: usuarioController.atividade.value,
        inicio: inicio.value,
        fim: fim.value));

    relatorioController.items = await dao.findAll(DateTime.now());
  }
}
