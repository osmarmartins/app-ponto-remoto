import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ponto_remoto/src/components/subtitulo_widget.dart';
import 'package:ponto_remoto/src/components/texto_comum_widget.dart';
import 'package:ponto_remoto/src/components/titulo_widget.dart';

import '../controllers/ponto_controller.dart';
import '../helpers/date_time_helper.dart';

// ignore: must_be_immutable
class PontoPage extends StatelessWidget {
  PontoPage({super.key});
  final tarefa = 'Manutenção do sistema';
  Duration intervalo = const Duration();
  Duration tempo = const Duration();

  final PontoController controller = Get.put(PontoController());

  DateTime hoje = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ponto')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              TituloWidget(texto: 'DATA: ${DateTimeHelper.formatarData(hoje)}'),
              SubTituloWidget(texto: tarefa),
              const Divider(height: 10),
              Obx(
                () => Expanded(
                  child: Image.asset(
                    controller.tarefaIniciada.value
                        ? 'assets/images/trabalhando.gif'
                        : 'assets/images/parado.png',
                    width: 200,
                  ),
                ),
              ),
              Obx(
                () => Center(
                    child: !controller.tarefaIniciada.value
                        ? _iniciar()
                        : _finalizar()),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () {
                  return Visibility(
                    visible: controller.tarefaIniciada.value,
                    child: TextoComumWidget(
                      texto:
                          'Iniciado as: ${DateTimeHelper.formatarHora(controller.inicio.value)}',
                    ),
                  );
                },
              ),
              Obx(
                () {
                  return Visibility(
                    visible: !controller.tarefaIniciada.value,
                    child: TextoComumWidget(
                      texto:
                          'Última Marcação: ${DateTimeHelper.formatarDuration(intervalo)}',
                    ),
                  );
                },
              ),
              Obx(
                () {
                  return Visibility(
                    visible: !controller.tarefaIniciada.value,
                    child: TextoComumWidget(
                      texto:
                          'Acumulado no dia: ${DateTimeHelper.formatarDuration(tempo)}',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _finalizar() {
    return ElevatedButton.icon(
      onPressed: () {
        intervalo = controller.fim.value.difference(controller.inicio.value);
        controller.fim(DateTime.now());
        tempo = tempo + intervalo;
        controller.tarefaIniciada(false);
      },
      icon: const Icon(Icons.timer_off_sharp),
      label: const Text('Finalizar'),
    );
  }

  ElevatedButton _iniciar() {
    return ElevatedButton.icon(
      onPressed: () {
        intervalo = controller.fim.value.difference(controller.inicio.value);
        controller.inicio(DateTime.now());
        controller.fim(DateTime.now());
        controller.tarefaIniciada(true);
      },
      icon: const Icon(Icons.timer_sharp),
      label: const Text('Iniciar'),
    );
  }
}
