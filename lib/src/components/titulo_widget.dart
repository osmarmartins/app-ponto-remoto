import 'package:flutter/material.dart';

class TituloWidget extends StatelessWidget {
  const TituloWidget({super.key, required this.texto});
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
    );
  }
}
