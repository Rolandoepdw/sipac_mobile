import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';
import 'package:sipac_mobile_4/core/styles/inputs_decoration.dart';
import 'package:sipac_mobile_4/core/utils/validators.dart';


class DynamicDropDownSearch<T> extends StatelessWidget {
  final List<T> _list;
  final void Function(T?) _callBack;
  final String _label;

  const DynamicDropDownSearch.name(this._list, this._callBack, this._label,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(lowPadding),
      child: DropdownSearch<T>(
          popupProps: PopupProps.menu(
              searchFieldProps: TextFieldProps(
                  decoration: dropDownInputDecoration(context, 'Buscar')),
              showSearchBox: true,
              menuProps: MenuProps(
                  borderRadius: BorderRadius.circular(mediumRadius),
                  barrierColor: Colors.transparent.withOpacity(0.4),
                  barrierDismissible: true),
              itemBuilder: (BuildContext context, T item, bool bolean) {
                return ListTile(
                  title: Text(item.toString(), softWrap: true),
                );
              }),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: textFormFieldDecoration(context, _label),
          ),
          items: _list,
          onChanged: _callBack,
          validator: (value) => dropDownValidator(value),
          dropdownButtonProps: DropdownButtonProps(
              icon: Icon(Icons.expand_circle_down, color: primaryColor))),
    );
  }
}
