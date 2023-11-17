import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';

class Alert extends StatelessWidget {
  String text;

  Alert({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(mediumPadding),
      ),
      icon: Icon(Icons.crisis_alert, size: 32, color: primaryColor),
      content: SingleChildScrollView(
        child: Center(child: Text(text, style: const TextStyle(fontSize: 16))),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CANCELAR')),
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('ACEPTAR'))
      ],
    );
  }
}
