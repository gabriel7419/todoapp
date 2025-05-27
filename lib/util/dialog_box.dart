import 'package:flutter/material.dart';
import 'package:todofr/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // obtém dados inseridos pelo usuário
            TextField(
              controller: controller,
              // decoração do campo de texto
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),

            // botões -> salvar + cancelar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // botão salvar
                MyButton(text: "Save", onPressed: onSave),

                const SizedBox(width: 24), // espaçamento entre os botões
                // botão cancelar
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
