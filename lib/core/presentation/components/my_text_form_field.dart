import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';
import 'package:sipac_mobile_4/core/styles/inputs_decoration.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;
  final TextCapitalization _textCapitalization;
  final TextInputType _keyboardType;
  final bool _obscureText;
  final String? Function(String?) _validator;

  const MyTextFormField.name(
      this._controller,
      this._label,
      this._textCapitalization,
      this._keyboardType,
      this._obscureText,
      this._validator,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(lowPadding),
      child: TextFormField(
          controller: _controller,
          textCapitalization: _textCapitalization,
          keyboardType: _keyboardType,
          obscureText: _obscureText,
          validator: _validator,
          decoration: textFormFieldDecoration(context, _label)),
    );
  }
}
