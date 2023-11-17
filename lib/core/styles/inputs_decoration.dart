import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';

InputDecoration textFormFieldDecoration(
    BuildContext context, String label) {
  return InputDecoration(
      label: Text(label),
      border: OutlineInputBorder(
          gapPadding: 12, borderRadius: BorderRadius.circular(mediumRadius)),
      counter: const Text(''));
}

InputDecoration dropDownInputDecoration(BuildContext context, String label) {
  return InputDecoration(
      label: Text(label),
      suffixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
      counter: const Text(''));
}
