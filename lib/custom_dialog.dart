import 'package:flutter/material.dart';
import 'package:gpt_voice_assistant_app/pallete.dart';

class CustomDialog extends StatelessWidget {
  final String message;

  const CustomDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Pallete.backgroundColor.withOpacity(0.9),
      content: Text(
        message,
        style: const TextStyle(
          color: Pallete.mainFontColor,
          fontFamily: 'Cera Pro',
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
