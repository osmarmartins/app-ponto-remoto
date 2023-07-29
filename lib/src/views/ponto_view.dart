import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ponto_remoto/src/components/subtitulo_widget.dart';
import 'package:ponto_remoto/src/components/texto_comum_widget.dart';
import 'package:ponto_remoto/src/components/titulo_widget.dart';
import 'package:ponto_remoto/src/controllers/relatorio_controller.dart';
import 'package:ponto_remoto/src/controllers/usuario_controller.dart';
import 'package:ponto_remoto/src/data/database.dart';

import '../controllers/ponto_controller.dart';
import '../helpers/date_time_helper.dart';
import '../models/ponto.dart';

class PontoPage extends StatelessWidget {
  PontoPage({super.key});
  final db = PontoDatabase();
  final PontoController controller = Get.put(PontoController());
  final UsuarioController usuarioController = Get.put(UsuarioController());
  final RelatorioController relatorioController =
      Get.put(RelatorioController());

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
                !controller.tarefaIniciada.value ? _iniciar() : _finalizar(),
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

  ElevatedButton _iniciar() {
    return ElevatedButton.icon(
      onPressed: () {
        controller.intervalo.value =
            controller.fim.value.difference(controller.inicio.value);
        controller.atividadeAtual.value =
            const Duration(seconds: 0, minutes: 0, hours: 0);
        controller.inicio.value = DateTime.now();
        controller.fim.value = DateTime.now();
        controller.tarefaIniciada.value = true;
      },
      icon: const Icon(Icons.timer_sharp),
      label: const Text('Iniciar'),
    );
  }

  ElevatedButton _finalizar() {
    return ElevatedButton.icon(
      onPressed: () {
        controller.fim.value = DateTime.now();
        controller.intervalo.value =
            controller.fim.value.difference(controller.inicio.value);
        controller.tempo.value += controller.intervalo.value;
        controller.tarefaIniciada.value = false;

        db.save(Ponto(
            usuario: usuarioController.nome.value,
            projeto: usuarioController.projeto.value,
            atividade: usuarioController.atividade.value,
            inicio: controller.inicio.value,
            fim: controller.fim.value));

        relatorioController.items = db.findAll();

        // relatorioController.adicionarPonto(Ponto(
        //     usuario: usuarioController.nome.value,
        //     projeto: usuarioController.projeto.value,
        //     atividade: usuarioController.atividade.value,
        //     inicio: controller.inicio.value,
        //     fim: controller.fim.value));
      },
      icon: const Icon(Icons.timer_off_sharp),
      label: const Text('Finalizar'),
    );
  }
}
