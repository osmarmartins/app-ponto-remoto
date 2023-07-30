import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ponto_remoto/src/components/campo_texto_widget.dart';
import 'package:ponto_remoto/src/components/titulo_widget.dart';
import 'package:ponto_remoto/src/controllers/usuario_controller.dart';
import 'package:ponto_remoto/src/data/usuario_dao.dart';
import 'package:ponto_remoto/src/models/usuario.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({super.key});

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  var controller = Get.put(UsuarioController());

  var campoNome = TextEditingController();
  var campoProjeto = TextEditingController();
  var campoAtividade = TextEditingController();

  var dao = UsuarioDAO();

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
                controller.projeto.value = campoProjeto.text;
                controller.atividade.value = campoAtividade.text;
                dao.save(
                  Usuario(
                    nome: campoNome.text,
                    projeto: campoProjeto.text,
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
