import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ponto_remoto/src/components/subtitulo_widget.dart';
import 'package:ponto_remoto/src/components/titulo_widget.dart';
import 'package:ponto_remoto/src/models/ponto.dart';

import '../controllers/relatorio_controller.dart';
import '../controllers/usuario_controller.dart';
import '../helpers/date_time_helper.dart';

class RelatorioPage extends StatelessWidget {
  RelatorioPage({super.key});

  final UsuarioController usuarioController = Get.put(UsuarioController());
  final RelatorioController controller = Get.put(RelatorioController());

  @override
  Widget build(BuildContext context) {
    var items = controller.pontos;
    var tempo = DateTimeHelper.formatarDuration(controller.tempoTotal());
    var periodo = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TituloWidget(
                texto: 'DATA: ${DateTimeHelper.formatarData(periodo)}'),
            SubTituloWidget(texto: 'Tempo total: $tempo'),
            const Divider(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return tile(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tile(Ponto item) {
    var inicio = DateTimeHelper.formatarHora(item.inicio);
    var fim = DateTimeHelper.formatarHora(item.fim!);
    return ListTile(
      title: Text('${item.projeto} - ${item.atividade}'),
      subtitle: Text('$inicio - $fim    Duração: ${item.duracao()}'),
    );
  }
}
