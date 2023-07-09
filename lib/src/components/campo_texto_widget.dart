import 'package:flutter/material.dart';

class CampoTextoWidget extends StatelessWidget {
  const CampoTextoWidget({
    super.key,
    required this.campo,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  final String campo;
  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: campo,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
