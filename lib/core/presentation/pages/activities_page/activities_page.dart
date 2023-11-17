import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipac_mobile_4/core/data/entities/activity.dart';
import 'package:sipac_mobile_4/core/domain/activity_cubit/activity_cubit.dart';
import 'package:sipac_mobile_4/core/presentation/components/alert.dart';
import 'package:sipac_mobile_4/core/presentation/components/date_range_piker.dart';
import 'package:sipac_mobile_4/core/presentation/pages/activity_detail_page/activity_detail_page.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';
import 'package:sipac_mobile_4/core/utils/activity_to_calendar_event.dart';
import 'package:sipac_mobile_4/core/utils/date_utils.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Activity> _allActivities = [];
  List<Activity> _filteredActivities = [];

  DateTime? _startDate;
  DateTime? _endDate;

  void _selectStartDate(DateTime? value) => setState(() {
        _startDate = value;
        _search();
      });

  void _selectEndDate(DateTime? value) => setState(() {
        _endDate = value;
        _search();
      });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ActivityCubit>(context).loadActivities();
    return Scaffold(
      appBar: AppBar(
          title: const Text('Actividades'), centerTitle: true, elevation: 0),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryColor,
        child: Icon(Icons.add, color: primaryColor),
        onPressed: () {
          Navigator.pushNamed(context, 'newActivityForm');
        },
      ),
      body: Container(
        color: primaryColor,
        child: BlocBuilder<ActivityCubit, ActivityState>(
          bloc: BlocProvider.of<ActivityCubit>(context),
          builder: (context, state) {
            if (state is ActivitiesLoaded) {
              if (state.activities.isNotEmpty) {
                _allActivities = state.activities;
                return Column(
                  children: [
                    SizedBox(
                      height: 56,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              lowPadding, 0, lowPadding, lowPadding),
                          child: SearchBar(
                            controller: _searchController,
                            leading: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.search,
                                  color: primaryColor,
                                )),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: lowPadding)),
                            trailing: [
                              IconButton(
                                  onPressed: _clearQuery,
                                  icon: Icon(
                                    Icons.close,
                                    color: primaryColor,
                                  ))
                            ],
                            hintText: 'Buscar',
                            elevation: MaterialStateProperty.all(0),
                          )),
                    ),
                    DateRangePiker(null, null, 0, secondaryColor, primaryColor,
                        true, _selectStartDate, _selectEndDate),
                    const Divider(
                        color: secondaryColor,
                        thickness: 1.4,
                        height: lowPadding,
                        indent: lowPadding,
                        endIndent: lowPadding),
                    _activitiesListView(context, _allActivities),
                  ],
                );
              }
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(highPadding),
                  child: Text(
                    'No existen actividades',
                    style: TextStyle(color: secondaryColor, fontSize: 18),
                  ),
                ),
              );
            }
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(highPadding),
              child: CircularProgressIndicator(strokeWidth: 6),
            ));
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(_queryListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.removeListener(_queryListener);
    _searchController.dispose();
    super.dispose();
  }

  void _queryListener() {
    _search();
  }

  void _search() {
    String query = _searchController.text;
    //Null
    if (_startDate == null && _endDate == null && query.isEmpty) {
      _filteredActivities = _allActivities;
    } else {
      //Limpiar
      _filteredActivities.clear();
    }

    //Fecha inicial, final y texto
    if (_startDate != null && _endDate != null && query.isNotEmpty) {
      _filteredActivities.addAll(_allActivities
          .where((activity) =>
              activity.startDate
                  .isAfter(_startDate!.subtract(const Duration(days: 1))) &&
              activity.endDate
                  .isBefore(_endDate!.add(const Duration(days: 1))) &&
              activity.denomination.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }

    //Fecha inicial y final
    if (_startDate != null && _endDate != null && query.isEmpty) {
      _filteredActivities.addAll(_allActivities
          .where((activity) =>
              activity.startDate
                  .isAfter(_startDate!.subtract(const Duration(days: 1))) &&
              activity.endDate.isBefore(_endDate!.add(const Duration(days: 1))))
          .toList());
    }

    //Fecha inicial y texto
    if (_startDate != null && _endDate == null && query.isNotEmpty) {
      _filteredActivities.addAll(_allActivities
          .where((activity) =>
              activity.startDate
                  .isAfter(_startDate!.subtract(const Duration(days: 1))) &&
              activity.denomination.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }

    //Fecha final y texto
    if (_startDate == null && _endDate != null && query.isNotEmpty) {
      _filteredActivities.addAll(_allActivities
          .where((activity) =>
              activity.endDate
                  .isBefore(_endDate!.add(const Duration(days: 1))) &&
              activity.denomination.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }

    //Fecha inicial
    if (_startDate != null && _endDate == null && query.isEmpty) {
      _filteredActivities.addAll(_allActivities
          .where((activity) => activity.startDate
              .isAfter(_startDate!.subtract(const Duration(days: 1))))
          .toList());
    }

    //Fecha final
    if (_startDate == null && _endDate != null && query.isEmpty) {
      _filteredActivities.addAll(_allActivities
          .where((activity) =>
              activity.endDate.isBefore(_endDate!.add(const Duration(days: 1))))
          .toList());
    }

    //Texto
    if (_startDate == null && _endDate == null && query.isNotEmpty) {
      _filteredActivities.addAll(_allActivities
          .where((activity) =>
              activity.denomination.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }

    setState(() {});
  }

  void _clearQuery() {
    _searchController.clear();
    FocusScope.of(context).unfocus();
  }

  Widget _activitiesListView(BuildContext context, List<Activity> result) {
    return Expanded(
      child: ListView.builder(
          itemCount: _filteredActivities.isEmpty &&
                  _searchController.text.isEmpty &&
                  _startDate == null &&
                  _endDate == null
              ? _allActivities.length
              : _filteredActivities.length,
          padding:
              const EdgeInsets.symmetric(vertical: lowPadding, horizontal: 2),
          itemBuilder: (context, index) {
            return _listTileActivity(
                context,
                _filteredActivities.isEmpty && _searchController.text.isEmpty
                    ? _allActivities[index]
                    : _filteredActivities[index]);
          }),
    );
  }

  Widget _listTileActivity(BuildContext context, Activity activity) {
    return Dismissible(
      key: Key('${activity.activityId}'),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Alert(text: '¿Desea eliminar la actividad?');
          },
        );
      },
      onDismissed: (direction) async {
        CalendarControllerProvider.of(context)
            .controller
            .remove(convertActivityToCalendarEvent(activity));
        _filteredActivities.remove(activity);
        final bloc = BlocProvider.of<ActivityCubit>(context);
        await bloc.deleteActivity(activity);
        await bloc.loadActivities();
        setState(() {});
      },
      child: Card(
        child: ListTile(
          splashColor: activity.activityColor,
          dense: true,
          // Todas del mismo tamaño
          key: Key('${activity.activityId}'),
          title: Text(activity.denomination),
          subtitle: Text(
              '${shortDate(activity.startDate)} - ${shortDate(activity.endDate)}'),
          leading: CircleAvatar(
              radius: 24,
              backgroundColor: activity.activityColor,
              foregroundColor: Colors.white,
              child: Text(activity.denomination.substring(0, 2))),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: activity.activityColor,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActivityDetailPage(activity),
              ),
            ).then((value) async {
              setState(() {});
            });
          },
        ),
      ),
    );
  }
}