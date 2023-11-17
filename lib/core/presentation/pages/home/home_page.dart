import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/data/user_preferences.dart';
import 'package:sipac_mobile_4/core/presentation/components/table_calendar/calendar_widget.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences = UserPreferences();
    return Scaffold(
      appBar: AppBar(
          title: const Text('Dashboard'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () async {
                  await userPreferences.removeUserPreferencesData();
                  Navigator.pushNamed(context, 'login');
                },
                icon: const Icon(Icons.logout))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(lowPadding),
        child: CalendarWidget(),
      ),
    );
  }
}
