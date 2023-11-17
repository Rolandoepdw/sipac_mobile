import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/data/entities/activity.dart';

class ActivitySearchBar extends StatefulWidget {
  final List<Activity> _allItems;
  final TextEditingController _controller;
  const ActivitySearchBar(this._controller, this._allItems, {super.key});

  @override
  State<ActivitySearchBar> createState() => _ActivitySearchBarState();
}

class _ActivitySearchBarState extends State<ActivitySearchBar> {
  List<Activity> _items = [];

  @override
  Widget build(BuildContext context) {
    return const SearchBar();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._controller.addListener(_queryListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget._controller.removeListener(_queryListener);
    widget._controller.dispose();
    super.dispose();
  }

  void _queryListener() {
    _search(widget._controller.text);
  }

  void _search(String query) {
    if (query.isEmpty) {
      setState(() {
        _items = widget._allItems;
      });
    } else {
      setState(() {
        _items = widget._allItems
            .where((element) => element.denomination
            .toLowerCase()
            .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  void _clearQuery() {
    widget._controller.clear();
    FocusScope.of(context).unfocus();
  }

}
