import 'package:calendar_view/calendar_view.dart';
import 'package:sipac_mobile_4/core/data/entities/activity.dart';
import 'package:sipac_mobile_4/core/presentation/components/table_calendar/calendar_data.dart';


CalendarEventData convertActivityToCalendarEvent(Activity activity) {
  return CalendarEventData<Activity>(
    title: activity.denomination,
    color: activity.activityColor,
    description: activity.place,
    date: activity.startDate,
    endDate: activity.endDate,
    event: activity,
    startTime: activity.startDate,
    endTime: activity.endDate,
  );
}

List<CalendarEventData> convertAllActivityToCalendarEvent(
        List<Activity> activities) =>
    activities
        .map((activity) => CalendarEventData<Activity>(
              title: activity.denomination,
              color: activity.activityColor,
              description: activity.place,
              date: activity.startDate,
              endDate: activity.endDate,
              event: activity,
              startTime: activity.startDate,
              endTime: activity.endDate,
            ))
        .toList();

List<TableCalendarData> convertAllActivityToCalendarData(
    List<Activity> activities) =>
    activities
        .map((activity) => TableCalendarData(
      eventName: activity.denomination,
      description: activity.place,
      startDate: activity.startDate,
      endDate: activity.endDate,
    ))
        .toList();