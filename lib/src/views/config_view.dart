import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ponto_remoto/src/components/campo_texto_widget.dart';
import 'package:ponto_remoto/src/components/titulo_widget.dart';
import 'package:ponto_remoto/src/controllers/config_controller.dart';
import 'package:ponto_remoto/src/data/config_dao.dart';
import 'package:ponto_remoto/src/models/config.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  var controller = Get.put(ConfigController());

  var campoNome = TextEditingController();
  var campoProjeto = TextEditingController();
  var campoAtividade = TextEditingController();

  var dao = ConfigDAO();

  @override
  Widget build(BuildContext context) {
    campoNome.text = controller.nome.value;
    campoProjeto.text = controller.projeto.value;
    campoAtividade.text = controller.atividade.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Usuário',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const TituloWidget(texto: 'Dados do Usuário'),
            const Divider(height: 10),
            const SizedBox(height: 20),
            CampoTextoWidget(
              campo: 'Nome',
              controller: campoNome,
            ),
            CampoTextoWidget(
              campo: 'Projeto',
              controller: campoProjeto,
              keyboardType: TextInputType.emailAddress,
            ),
            CampoTextoWidget(
              campo: 'Atividade/Tarefa',
              controller: campoAtividade,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                controller.nome.value = campoNome.text;
                controller.projeto.value = campoProjeto.text.toUpperCase();
                controller.atividade.value = campoAtividade.text;
                dao.save(
                  Config(
                    nome: campoNome.text,
                    projeto: campoProjeto.text.toUpperCase(),
                    tarefa: campoAtividade.text,
                  ),
                );
                FocusScope.of(context).unfocus();
              },
              icon: const Icon(Icons.check),
              label: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
