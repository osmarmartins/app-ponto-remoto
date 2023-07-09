import 'package:flutter/material.dart';

class SubTituloWidget extends StatelessWidget {
  const SubTituloWidget({super.key, required this.texto});
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
    );
  }
}
