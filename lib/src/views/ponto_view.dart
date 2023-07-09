import 'package:flutter/material.dart';
import 'package:ponto_remoto/src/components/subtitulo_widget.dart';
import 'package:ponto_remoto/src/components/texto_comum_widget.dart';
import 'package:ponto_remoto/src/components/titulo_widget.dart';

import '../helpers/date_time_helper.dart';

// ignore: must_be_immutable
class PontoPage extends StatefulWidget {
  PontoPage({super.key});
  final tarefa = 'Manutenção do sistema';
  bool tarefaIniciada = false;
  DateTime inicio = DateTime.now();
  DateTime fim = DateTime.now();
  Duration intervalo = const Duration();
  Duration tempo = const Duration();

  @override
  State<PontoPage> createState() => _PontoPageState();
}

class _PontoPageState extends State<PontoPage> {
  DateTime hoje = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ponto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              TituloWidget(texto: 'DATA: ${DateTimeHelper.formatarData(hoje)}'),
              SubTituloWidget(texto: widget.tarefa),
              const Divider(height: 10),
              Expanded(
                child: Image.asset(
                  widget.tarefaIniciada
                      ? 'assets/images/trabalhando.gif'
                      : 'assets/images/parado.png',
                  width: 200,
                ),
              ),
              !widget.tarefaIniciada
                  ? ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          widget.inicio = DateTime.now();
                          widget.fim = DateTime.now();
                          widget.intervalo =
                              widget.fim.difference(widget.inicio);
                          widget.tarefaIniciada = true;
                        });
                      },
                      icon: const Icon(Icons.timer_sharp),
                      label: const Text('Iniciar'),
                    )
                  : ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          widget.fim = DateTime.now();
                          widget.intervalo =
                              widget.fim.difference(widget.inicio);
                          widget.tempo = widget.tempo + widget.intervalo;
                          widget.tarefaIniciada = false;
                        });
                      },
                      icon: const Icon(Icons.timer_off_sharp),
                      label: const Text('Finalizar'),
                    ),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                visible: widget.tarefaIniciada,
                child: TextoComumWidget(
                  texto:
                      'Iniciado as: ${DateTimeHelper.formatarHora(widget.inicio)}',
                ),
              ),
              Visibility(
                visible: !widget.tarefaIniciada,
                child: TextoComumWidget(
                  texto:
                      'Última Marcação: ${DateTimeHelper.formatarDuration(widget.intervalo)}',
                ),
              ),
              Visibility(
                visible: !widget.tarefaIniciada,
                child: TextoComumWidget(
                  texto:
                      'Acumulado no dia: ${DateTimeHelper.formatarDuration(widget.tempo)}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
