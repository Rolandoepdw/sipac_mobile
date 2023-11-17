String? passwordValidator(value, label) {
  if (value.length < 1) {
    return 'La $label es débil';
  } else {
    return null;
  }
}

String? nameValidator(value, label) {
  if (value.isEmpty) return 'Introduce algun $label';
  RegExp rex = RegExp(r"^[\p{L} ,.'-]*$",
      caseSensitive: false, unicode: true, dotAll: true);
  if (!rex.hasMatch(value)) {
    return 'Introduce un $label válido';
  } else {
    return null;
  }
}

String? textValidator(value, label) {
  if (value.isEmpty) {
    return 'Introduce algún $label';
  } else {
    return null;
  }
}

String? dropDownValidator(value) {
  if (value == null) {
    return 'Selecciona un valor';
  return null;
  }
  return null;
}
