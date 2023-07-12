import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ponto_remoto/src/views/menu_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
    );
  }
}
