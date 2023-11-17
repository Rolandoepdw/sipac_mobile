import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/data/user_preferences.dart';
import 'package:sipac_mobile_4/core/presentation/components/my_text_form_field.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';
import 'package:sipac_mobile_4/core/utils/validators.dart';

class ServerInput extends StatelessWidget {
  final _formServerKey = GlobalKey<FormState>();
  final TextEditingController _serverController;
  UserPreferences userPreferences = UserPreferences();

  ServerInput(this._serverController, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(mediumPadding),
      ),
      icon: Icon(Icons.dns_rounded, size: 32, color: primaryColor),
      content: Form(
        key: _formServerKey,
        child: SingleChildScrollView(
          child: _buildServerField(),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CANCELAR')),
        TextButton(
            onPressed: () {
              userPreferences.userData = _serverController.text;
              Navigator.of(context).pop(true);
            },
            child: const Text('GUARDAR'))
      ],
    );
  }

  Widget _buildServerField() {
    return MyTextFormField.name(
        _serverController,
        'Servidor',
        TextCapitalization.sentences,
        TextInputType.url,
        false,
        (value) => nameValidator(value, 'ip'));
  }
}
