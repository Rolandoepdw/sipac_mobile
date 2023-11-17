import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';
import 'package:sipac_mobile_4/core/utils/date_utils.dart';

class CalendarMonthView extends StatelessWidget {
  const CalendarMonthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MonthView(
      useAvailableVerticalSpace: true,
      controller: CalendarControllerProvider.of(context).controller,
      headerStyle: HeaderStyle(
        headerMargin: const EdgeInsets.all(lowPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(highRadius),
        ),
      ),
      headerStringBuilder: (DateTime date, {DateTime? secondaryDate}) {
        if (secondaryDate != null && date.month != secondaryDate.month) {
          return '${date.month}/${date.year} - ${secondaryDate.month}/${secondaryDate.year}';
        } else {
          return '${date.month}/${date.year}';
        }
      },
      minMonth: DateTime(now.year, 1, 1),
      maxMonth: DateTime(now.year, 12, 31),
      initialMonth: now,
      startDay: WeekDays.monday,
      onEventTap: (events, date) => print(events),
      onDateLongPress: (date) => print(date),
    );
  }
}
