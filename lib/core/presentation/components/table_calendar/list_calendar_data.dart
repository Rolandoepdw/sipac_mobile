import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/presentation/components/table_calendar/calendar_data.dart';
import 'package:sipac_mobile_4/core/presentation/components/table_calendar/calendar_item.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';

class ListCalendarData extends StatelessWidget {
  final List<TableCalendarData> calendarData;

  const ListCalendarData({Key? key, required this.calendarData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: calendarData
            .asMap()
            .entries
            .map((data) => Padding(
                padding: EdgeInsets.only(
                    bottom:
                        data.key != calendarData.length - 1 ? lowPadding : 0),
                child: CalendarItem(
                  calendarItemData: data.value,
                )))
            .toList());
  }
}
