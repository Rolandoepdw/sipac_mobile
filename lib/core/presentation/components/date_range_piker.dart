import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/utils/date_utils.dart';

class DateRangePiker extends StatefulWidget {
  final DateTime? _startDate;
  final DateTime? _endDate;

  final double _elevation;
  final Color _buttonColor;
  final Color _fontColor;
  final bool _showRefresh;

  final void Function(DateTime?) _selectStartDate;
  final void Function(DateTime?) _selectEndDate;

  const DateRangePiker(
      this._startDate,
      this._endDate,
      this._elevation,
      this._buttonColor,
      this._fontColor,
      this._showRefresh,
      this._selectStartDate,
      this._selectEndDate,
      {super.key});

  @override
  State<DateRangePiker> createState() =>
      _DateRangePikerState(_startDate, _endDate);
}

class _DateRangePikerState extends State<DateRangePiker> {
  DateTime? _startDate;
  DateTime? _endDate;

  String _textStartDate = 'Fecha inicial';
  String _textEndDate = ' Fecha final ';

  _DateRangePikerState(this._startDate, this._endDate) {
    if (_startDate != null) _textStartDate = longDate(_startDate!);
    if (_endDate != null) _textEndDate = longDate(_endDate!);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget._showRefresh) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(widget._elevation),
                  backgroundColor:
                      MaterialStateProperty.all(widget._buttonColor)),
              child: Text(_textStartDate,
                  style: TextStyle(fontSize: 13, color: widget._fontColor)),
              onPressed: () {
                pickStartDate(context);
              }),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(widget._elevation),
                    backgroundColor:
                        MaterialStateProperty.all(widget._buttonColor)),
                child: Text(_textEndDate,
                    style: TextStyle(fontSize: 13, color: widget._fontColor)),
                onPressed: () {
                  pickEndDate(context);
                }))
      ]);
    } else {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(widget._elevation),
                backgroundColor:
                    MaterialStateProperty.all(widget._buttonColor)),
            child: Text(_textStartDate,
                style: TextStyle(fontSize: 13, color: widget._fontColor)),
            onPressed: () {
              pickStartDate(context);
            }),
        IconButton(
            onPressed: () {
              setState(() {
                _startDate = null;
                _endDate = null;
                widget._selectStartDate(null);
                widget._selectEndDate(null);
                _textStartDate = 'Fecha inicial';
                _textEndDate = ' Fecha final ';
              });
            },
            icon: const Icon(Icons.refresh_outlined)),
        ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(widget._elevation),
                backgroundColor:
                    MaterialStateProperty.all(widget._buttonColor)),
            child: Text(_textEndDate,
                style: TextStyle(fontSize: 13, color: widget._fontColor)),
            onPressed: () {
              pickEndDate(context);
            })
      ]);
    }
  }

  Future pickStartDate(BuildContext context) async {
    DateTime? startDate = await showDatePicker(
        context: context,
        firstDate: DateTime(now.year),
        lastDate: DateTime(now.year + 1),
        initialDate: now,
        initialEntryMode: DatePickerEntryMode.calendarOnly);

    if (startDate == null) return;

    TimeOfDay? startTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (startTime == null) return;

    setState(() {
      _startDate = DateTime(startDate.year, startDate.month, startDate.day,
          startTime.hour, startTime.minute);
      _textStartDate = longDate(_startDate!);
      widget._selectStartDate(_startDate!);
    });
  }

  Future pickEndDate(BuildContext context) async {
    DateTime? endDate = await showDatePicker(
        context: context,
        firstDate: (DateTime(now.year)),
        lastDate: (DateTime(now.year + 1)),
        initialDate: now,
        initialEntryMode: DatePickerEntryMode.calendarOnly);

    if (endDate == null) return;

    TimeOfDay? endTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (endTime == null) return;

    setState(() {
      _endDate = DateTime(endDate.year, endDate.month, endDate.day,
          endTime.hour, endTime.minute);
      _textEndDate = longDate(_endDate!);
      widget._selectEndDate(_endDate!);
    });
  }

  void reset() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _textStartDate = 'Fecha inicial';
      _textEndDate = ' Fecha final ';
    });
  }
}
