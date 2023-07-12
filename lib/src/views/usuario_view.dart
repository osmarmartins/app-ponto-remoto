import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ponto_remoto/src/components/campo_texto_widget.dart';
import 'package:ponto_remoto/src/components/titulo_widget.dart';
import 'package:ponto_remoto/src/controllers/usuario_controller.dart';

class UsuarioPage extends StatefulWidget {
  const UsuarioPage({super.key});

  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  var controller = Get.put(UsuarioController());

  var nomeController = TextEditingController();
  var emailController = TextEditingController();
  var tarefaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nomeController.text = controller.nome.value;
    emailController.text = controller.email.value;
    tarefaController.text = controller.atividade.value;
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
              controller: nomeController,
            ),
            CampoTextoWidget(
              campo: 'E-mail',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            CampoTextoWidget(
              campo: 'Atividade/Tarefa',
              controller: tarefaController,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                controller.nome.value = nomeController.text;
                controller.email.value = emailController.text;
                controller.atividade.value = tarefaController.text;
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
