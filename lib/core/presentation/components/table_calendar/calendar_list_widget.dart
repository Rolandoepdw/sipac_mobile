import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/presentation/components/table_calendar/calendar_data.dart';
import 'package:sipac_mobile_4/core/presentation/components/table_calendar/wrapper.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';

import 'list_calendar_data.dart';

class CalendarList extends StatelessWidget {
  final List<TableCalendarData> data;

  const CalendarList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("🔥 Eventos del día", style: TextStyle(fontSize: 16)),
        const SizedBox(
          height: lowPadding,
        ),
        Wrapper(
          child: ListCalendarData(calendarData: data),
        ),
      ],
    );
  }
}
