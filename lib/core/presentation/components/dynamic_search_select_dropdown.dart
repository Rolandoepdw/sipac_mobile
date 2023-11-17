import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';
import 'package:sipac_mobile_4/core/styles/inputs_decoration.dart';

class DynamicSearchSelectDropDown extends StatefulWidget {
  final List<dynamic> _list;
  final List<dynamic> _selectedItems;
  final void Function(dynamic) _callBack;
  final String _label;

  const DynamicSearchSelectDropDown.name(
      this._list, this._selectedItems, this._callBack, this._label,
      {super.key});

  @override
  State<DynamicSearchSelectDropDown> createState() =>
      _DynamicSearchSelectDropDownState();
}

class _DynamicSearchSelectDropDownState
    extends State<DynamicSearchSelectDropDown> {
  final _multiKey = GlobalKey<DropdownSearchState<dynamic>>();
  final _popupBuilderKey = GlobalKey<DropdownSearchState<dynamic>>();
  bool? _popupBuilderSelection = false;

  @override
  Widget build(BuildContext context) {
    _handleCheckBoxState(updateState: false);

    return Padding(
      padding: const EdgeInsets.all(lowPadding),
      child: DropdownSearch<dynamic>.multiSelection(
        key: _multiKey,
        items: widget._list,
        onChanged: widget._callBack,
        popupProps: PopupPropsMultiSelection.dialog(
          onItemAdded: (l, s) => _handleCheckBoxState(),
          onItemRemoved: (l, s) => _handleCheckBoxState(),
          showSearchBox: true,
          dialogProps: DialogProps(
              barrierColor: Colors.transparent.withOpacity(0.4),
              barrierDismissible: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(mediumRadius))),
          searchFieldProps: TextFieldProps(
              decoration: dropDownInputDecoration(context, 'Buscar')),
          containerBuilder: (ctx, popupWidget) {
            return Padding(
              padding: const EdgeInsets.all(lowPadding),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: lowPadding),
                        child: ElevatedButton(
                          onPressed: () {
                            // How should I unselect all items in the list?
                            _multiKey.currentState?.closeDropDownSearch();
                          },
                          child: const Icon(Icons.clear_outlined),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: lowPadding),
                        child: ElevatedButton(
                          onPressed: () {
                            // How should I select all items in the list?
                            _multiKey.currentState?.popupSelectAllItems();
                          },
                          child: const Icon(Icons.done_all_outlined),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: lowPadding),
                        child: ElevatedButton(
                          onPressed: () {
                            // How should I unselect all items in the list?
                            _multiKey.currentState?.popupDeselectAllItems();
                          },
                          child: const Icon(Icons.delete_outline),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: popupWidget),
                ],
              ),
            );
          },
        ),
        selectedItems: widget._selectedItems,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration:
              textFormFieldDecoration(context, widget._label),
        ),
        dropdownButtonProps: DropdownButtonProps(
            icon: Icon(Icons.expand_circle_down, color: primaryColor)),
      ),
    );
  }

  void _handleCheckBoxState({bool updateState = true}) {
    var selectedItem =
        _popupBuilderKey.currentState?.popupGetSelectedItems ?? [];
    var isAllSelected =
        _popupBuilderKey.currentState?.popupIsAllItemSelected ?? false;
    _popupBuilderSelection =
        selectedItem.isEmpty ? false : (isAllSelected ? true : null);

    if (updateState) setState(() {});
  }
}
