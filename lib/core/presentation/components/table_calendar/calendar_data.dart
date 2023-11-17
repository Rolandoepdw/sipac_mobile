import 'package:intl/intl.dart';

class TableCalendarData {
  String eventName;
  String description;
  DateTime startDate;
  DateTime endDate;

  TableCalendarData(
      {required this.eventName,
      required this.description,
      required this.startDate,
      required this.endDate});

  factory TableCalendarData.fromJson(Map<String, dynamic> json) => TableCalendarData(
    eventName: json["eventName"],
    description: json["description"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
  );

  String getStartDate() {
    final formatter = DateFormat('kk:mm');
    return formatter.format(startDate);
  }

  String getEndDate() {
    final formatter = DateFormat('kk:mm');
    return formatter.format(endDate);
  }
}
