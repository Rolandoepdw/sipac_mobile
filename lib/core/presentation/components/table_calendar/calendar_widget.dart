import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sipac_mobile_4/core/domain/activity_cubit/activity_cubit.dart';
import 'package:sipac_mobile_4/core/presentation/components/table_calendar/calendar_data.dart';
import 'package:sipac_mobile_4/core/presentation/components/table_calendar/calendar_list_widget.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';
import 'package:sipac_mobile_4/core/utils/activity_to_calendar_event.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<TableCalendarData> calendarData = [];
  List<TableCalendarData> _selectedDate = [];

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<TableCalendarData> _eventLoader(DateTime date) {
    return calendarData
        .where((element) =>
            date.isAfter(element.startDate.subtract(const Duration(days: 1))) &&
            date.isBefore(element.endDate.add(const Duration(days: 1))))
        .toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedDate = calendarData
            .where((element) =>
                selectedDay.isAfter(
                    element.startDate.subtract(const Duration(days: 1))) &&
                selectedDay
                    .isBefore(element.endDate.add(const Duration(days: 1))))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ActivityCubit>(context).loadActivities();

    return BlocBuilder<ActivityCubit, ActivityState>(
        bloc: BlocProvider.of<ActivityCubit>(context),
        builder: (context, state) {
          if (state is ActivitiesLoaded) {
            if (state.activities.isNotEmpty) {
              calendarData =
                  (convertAllActivityToCalendarData(state.activities));
            }
          }
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(lowRadius)),
                padding: const EdgeInsets.all(lowPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat("d  MMM  yyyy").format(_focusedDay),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _focusedDay = DateTime(
                                      _focusedDay.year, _focusedDay.month - 1);
                                });
                              },
                              child: Icon(
                                Icons.chevron_left,
                                color: primaryColor,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _focusedDay = DateTime(
                                      _focusedDay.year, _focusedDay.month + 1);
                                });
                              },
                              child: Icon(
                                Icons.chevron_right,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: lowPadding),
                    TableCalendar<TableCalendarData>(
                      calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, day, events) {
                        if (events.isNotEmpty) {
                          return Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                // Puedes personalizar el color del número
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  events.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }),
                      selectedDayPredicate: (day) =>
                          isSameDay(_focusedDay, day),
                      focusedDay: _focusedDay,
                      firstDay: DateTime.utc(2022),
                      lastDay: DateTime.utc(2050),
                      headerVisible: false,
                      onDaySelected: _onDaySelected,
                      onFormatChanged: (result) {},
                      daysOfWeekStyle: DaysOfWeekStyle(
                        dowTextFormatter: (date, locale) {
                          return DateFormat("EEE").format(date).toUpperCase();
                        },
                        weekendStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        weekdayStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPageChanged: (day) {
                        _focusedDay = day;
                        setState(() {});
                      },
                      calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      )),
                      eventLoader: _eventLoader,
                    )
                  ],
                ),
              ),
              const SizedBox(height: lowPadding),
              Container(
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(lowRadius)),
                  padding: const EdgeInsets.all(lowPadding),
                  child: CalendarList(data: _selectedDate))
            ],
          );
        });
  }

  refreshCalendar() {
    setState(() {});
  }
}
