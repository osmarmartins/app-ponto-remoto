import 'package:flutter/material.dart';
import 'package:ponto_remoto/src/components/subtitulo_widget.dart';
import 'package:ponto_remoto/src/components/titulo_widget.dart';

class RelatorioPage extends StatelessWidget {
  const RelatorioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Relatório',
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TituloWidget(texto: 'Atividades do Mês'),
              SubTituloWidget(texto: 'Julho/2023'),
              Divider(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
