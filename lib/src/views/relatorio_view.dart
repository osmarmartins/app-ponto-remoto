import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Relatório - Duração $tempo',
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            title: Text('${item.projeto} - ${item.atividade}'),
            subtitle: Text(item.duracao()),
          );
        },
      ),
    );
  }
}
