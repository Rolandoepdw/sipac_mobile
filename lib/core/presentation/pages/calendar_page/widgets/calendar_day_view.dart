import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';
import 'package:sipac_mobile_4/core/utils/date_utils.dart';


class CalendarDayView extends StatelessWidget {
  const CalendarDayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DayView(
      controller: CalendarControllerProvider.of(context).controller,
      backgroundColor: secondaryColor,
      hourIndicatorSettings: HourIndicatorSettings(color: primaryColor.withOpacity(0.2)),
      minuteSlotSize: MinuteSlotSize.minutes30,
      verticalLineOffset: 0,
      liveTimeIndicatorSettings:
          HourIndicatorSettings(color: primaryColor),
      timeLineWidth: 52,
      headerStyle: HeaderStyle(
        headerMargin: const EdgeInsets.all(lowPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(highRadius),
        ),
      ),
      dateStringBuilder: (DateTime date, {DateTime? secondaryDate}) {
        if (secondaryDate != null && date.month != secondaryDate.month) {
          return '${date.day}/${date.month}/${date.year} - ${secondaryDate.day}/${secondaryDate.month}/${secondaryDate.year}';
        } else {
          return '${date.day}/${date.month}/${date.year}';
        }
      },
      eventTileBuilder: (date, events, boundry, start, end) {
        // Return your widget to display as event tile.
        return Container(
            decoration: BoxDecoration(
                color: events.first.color,
                borderRadius: BorderRadius.circular(lowRadius)),
            child: Padding(
                padding: const EdgeInsets.all(lowPadding),
                child: Text(events.first.title,
                    style: const TextStyle(fontSize: 24, color: textColorWhite))));
      },
      showVerticalLine: true,
      // To display live time line in day view.
      showLiveTimeLineInAllDays: true,
      // To display live time line in all pages in day view.
      initialDay: now,
      minDay: DateTime(now.year, 1, 1),
      maxDay: DateTime(now.year, 12, 31),
      heightPerMinute: 1.1,
      // height occupied by 1 minute time span.
      eventArranger: const SideEventArranger(),
      // To define how simultaneous events will be arranged.
      onEventTap: (events, date) => print(events),
      onDateLongPress: (date) => print(date),
    );
  }
}
