import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipac_mobile_4/core/domain/activity_cubit/activity_cubit.dart';
import 'package:sipac_mobile_4/core/presentation/pages/calendar_page/widgets/calendar_day_view.dart';
import 'package:sipac_mobile_4/core/presentation/pages/calendar_page/widgets/calendar_month_view.dart';
import 'package:sipac_mobile_4/core/presentation/pages/calendar_page/widgets/calendar_week_view.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';
import 'package:sipac_mobile_4/core/utils/activity_to_calendar_event.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ActivityCubit>(context).loadActivities();

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            title: const Text('Calendario'),
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            bottom: TabBar(
                controller: tabController,
                labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                splashBorderRadius: BorderRadius.circular(lowRadius),
                indicatorColor: secondaryColor,
                tabs: const [Text('Diario'), Text('Semanal'), Text('Mensual')]),
          ),
        ),
        body: BlocBuilder<ActivityCubit, ActivityState>(
          bloc: BlocProvider.of<ActivityCubit>(context),
          builder: (context, state) {
            if (state is ActivitiesLoaded) {
              if (state.activities.isNotEmpty &&
                  CalendarControllerProvider.of(context)
                      .controller
                      .events
                      .isEmpty) {
                CalendarControllerProvider.of(context).controller.addAll(
                    convertAllActivityToCalendarEvent(state.activities));
              }
              return TabBarView(controller: tabController, children: const [
                CalendarDayView(),
                CalendarWeekView(),
                CalendarMonthView(),
              ]);
            }
            return Stack(children: [
              TabBarView(controller: tabController, children: const [
                CalendarDayView(),
                CalendarWeekView(),
                CalendarMonthView(),
              ]),
              const Center(child: CircularProgressIndicator(strokeWidth: 6))
            ]);
          },
        ));
  }
}
