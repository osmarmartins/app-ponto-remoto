import 'package:flutter/material.dart';

class TextoWidget extends StatelessWidget {
  const TextoWidget({super.key, required this.texto});
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
