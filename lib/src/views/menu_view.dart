import 'package:flutter/material.dart';
import 'package:ponto_remoto/src/views/ponto_view.dart';
import 'package:ponto_remoto/src/views/relatorio_view.dart';
import 'package:ponto_remoto/src/views/usuario_view.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int menuIndex = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          PontoPage(),
          const RelatorioPage(),
          const UsuarioPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: menuIndex,
        onTap: (index) {
          setState(() {
            menuIndex = index;
            pageController.jumpToPage(index);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_sharp),
            label: 'Ponto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Relatório',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Usuário',
          ),
        ],
      ),
    );
  }
}
