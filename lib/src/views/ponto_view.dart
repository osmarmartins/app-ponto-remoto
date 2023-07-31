import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ponto_remoto/src/components/subtitulo_widget.dart';
import 'package:ponto_remoto/src/components/texto_comum_widget.dart';
import 'package:ponto_remoto/src/components/titulo_widget.dart';
import 'package:ponto_remoto/src/controllers/ponto_controller.dart';
import 'package:ponto_remoto/src/controllers/relatorio_controller.dart';
import 'package:ponto_remoto/src/controllers/usuario_controller.dart';
import 'package:ponto_remoto/src/data/ponto_dao.dart';
import 'package:ponto_remoto/src/helpers/date_time_helper.dart';

class PontoPage extends StatelessWidget implements Bindings {
  PontoPage({super.key});
  final db = PontoDAO();
  final PontoController controller = Get.put(PontoController());
  final UsuarioController usuarioController = Get.put(UsuarioController());
  final RelatorioController relatorioController =
      Get.put(RelatorioController());

  @override
  void dependencies() {
    Get.lazyPut(() => PontoController());
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      controller.atividadeAtual.value =
          DateTime.now().difference(controller.inicio.value);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Ponto')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Obx(
            () => Column(
              children: [
                TituloWidget(
                    texto:
                        'DATA: ${DateTimeHelper.formatarData(DateTime.now())}'),
                SubTituloWidget(
                  texto: usuarioController.getDescricaoAtividade(),
                ),
                const Divider(height: 10),
                Expanded(
                  child: Image.asset(
                    controller.tarefaIniciada.value
                        ? 'assets/images/trabalhando.gif'
                        : 'assets/images/parado.png',
                    width: 200,
                  ),
                ),
                !controller.tarefaIniciada.value
                    ? _botaoIniciar()
                    : _botaoFinalizar(),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: controller.tarefaIniciada.value,
                  child: TextoComumWidget(
                    texto:
                        'Iniciou: ${DateTimeHelper.formatarHora(controller.inicio.value)}',
                  ),
                ),
                Visibility(
                  visible: controller.tarefaIniciada.value,
                  child: SubTituloWidget(
                    texto:
                        'Atividade Atual: ${DateTimeHelper.formatarDuration(controller.atividadeAtual.value)}',
                  ),
                ),
                Visibility(
                  visible: !controller.tarefaIniciada.value &&
                      controller.tempo.value > const Duration(seconds: 0),
                  child: TextoComumWidget(
                    texto:
                        'Finalizou: ${DateTimeHelper.formatarHora(controller.fim.value)}',
                  ),
                ),
                Visibility(
                  visible: controller.tempo.value > const Duration(seconds: 0),
                  child: TextoComumWidget(
                    texto:
                        'Última Atividade: ${DateTimeHelper.formatarDuration(controller.intervalo.value)}',
                  ),
                ),
                Visibility(
                  visible: controller.tempo.value > const Duration(seconds: 0),
                  child: TextoComumWidget(
                    texto:
                        'Acumulado no dia: ${DateTimeHelper.formatarDuration(controller.tempo.value)}',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _botaoIniciar() {
    return ElevatedButton.icon(
      onPressed: () => controller.iniciarPonto(),
      icon: const Icon(Icons.timer_sharp),
      label: const Text('Iniciar'),
    );
  }

  ElevatedButton _botaoFinalizar() {
    return ElevatedButton.icon(
      onPressed: () => controller.finalizarPonto(),
      icon: const Icon(Icons.timer_off_sharp),
      label: const Text('Finalizar'),
    );
  }
}
