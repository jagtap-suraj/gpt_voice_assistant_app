import 'package:flutter/material.dart';
import 'package:gpt_voice_assistant_app/pallete.dart';

class CustomDialog extends StatelessWidget {
  final String message;

  const CustomDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Pallete.greyColor,
      content: Text(message),
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
