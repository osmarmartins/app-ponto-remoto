import 'package:flutter/material.dart';

class TextoComumWidget extends StatelessWidget {
  const TextoComumWidget({super.key, required this.texto});
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
