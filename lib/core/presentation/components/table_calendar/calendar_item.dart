import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/presentation/components/table_calendar/calendar_data.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';

class CalendarItem extends StatelessWidget {
  final TableCalendarData calendarItemData;

  const CalendarItem({Key? key, required this.calendarItemData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.only(bottom: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 24,
                  // backgroundColor: calendarItemData.activityColor,
                  foregroundColor: Colors.white,
                  child: Text(calendarItemData.eventName.substring(0, 2))),
              const SizedBox(width: 8),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(calendarItemData.eventName,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: lowPadding),
                    Text(calendarItemData.description,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis)
                  ],
                ),
              )
            ],
          ),
          Column(children: [
            _Date(date: calendarItemData.getStartDate()),
            const SizedBox(height: lowPadding),
            _Date(date: calendarItemData.getEndDate()),
          ])
        ],
      ),
    );
  }
}

class _Date extends StatelessWidget {
  final String date;

  const _Date({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: primaryColor,
        ),
      ),
      child: Text(
        date,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
