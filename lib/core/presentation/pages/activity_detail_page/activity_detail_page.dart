import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipac_mobile_4/core/data/entities/activity.dart';
import 'package:sipac_mobile_4/core/domain/activity_cubit/activity_cubit.dart';
import 'package:sipac_mobile_4/core/presentation/components/alert.dart';
import 'package:sipac_mobile_4/core/presentation/pages/edit_activity_form/edit_activity_form.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';
import 'package:sipac_mobile_4/core/styles/text_styles.dart';
import 'package:sipac_mobile_4/core/utils/activity_to_calendar_event.dart';
import 'package:sipac_mobile_4/core/utils/date_utils.dart';
import 'package:sipac_mobile_4/core/utils/utils.dart';


class ActivityDetailPage extends StatefulWidget {
  final Activity _activity;

  const ActivityDetailPage(this._activity, {Key? key}) : super(key: key);

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  // this variable determines whether the back-to-top button is shown or not
  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 100) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget._activity.activityColor,
      appBar: AppBar(
        backgroundColor: widget._activity.activityColor,
        title: Text(widget._activity.denomination),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditActivityForm(widget._activity),
                  ),
                ).then((value) async {
                  setState(() {});
                });
              },
              icon: const Icon(Icons.edit_outlined)),
          IconButton(
              onPressed: () async {
                if (await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Alert(text: '¿Desea eliminar la actividad?');
                  },
                )) {
                  final bloc = BlocProvider.of<ActivityCubit>(context);
                  await bloc.deleteActivity(widget._activity);
                  if (bloc.state is ActivityDeleted) {
                    CalendarControllerProvider.of(context).controller.remove(
                        convertActivityToCalendarEvent(widget._activity));
                    await bloc.loadActivities();
                  }
                  Navigator.of(context).pop();
                  setState(() {});
                }
              },
              icon: const Icon(Icons.delete_outline))
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(lowPadding),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildDenominationAndPlace(context),
                _buildDateRange(context),
                _buildStrategyAndLeaders(context),
                _buildChecks(context),
                _buildObjectives(context),
                _buildProcesses(context),
                _buildParticipants(context),
                _buildExternalParticipants(context)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }

  Widget _buildDenominationAndPlace(BuildContext context) {
    return _buildBox(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('DENOMINACIÓN:', style: textStyleFS16FWb),
            Text(widget._activity.denomination, style: textStyleFS16),
            const SizedBox(height: mediumPadding),
            const Text('LUGAR:', style: textStyleFS16FWb),
            Text(widget._activity.place, style: textStyleFS16),
          ],
        ));
  }

  Widget _buildDateRange(BuildContext context) {
    return _buildBox(
        context,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  Text(longDate(widget._activity.startDate),
                      style: textStyleFS16FWb),
                  const SizedBox(height: 3),
                  const Text('Fecha inicial', style: textStyleFS12FWb)
                ],
              ),
            ),
            const SizedBox(height: highPadding, child: VerticalDivider()),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  Text(longDate(widget._activity.endDate),
                      style: textStyleFS16FWb),
                  const SizedBox(height: 3),
                  const Text('Fecha final', style: textStyleFS12FWb)
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildStrategyAndLeaders(BuildContext context) {
    return _buildBox(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ESTRATEGIA:', style: textStyleFS16FWb),
            Text(widget._activity.strategy?.name ?? '-', style: textStyleFS16),
            const SizedBox(height: mediumPadding),
            const Text('LIDER INTERNO:', style: textStyleFS16FWb),
            Text(widget._activity.internalLeader?.name ?? '-',
                style: textStyleFS16),
            const SizedBox(height: mediumPadding),
            const Text('LIDER EXTERNO:', style: textStyleFS16FWb),
            Text(widget._activity.externalLeader, style: textStyleFS16),
          ],
        ));
  }

  Widget _buildObjectives(BuildContext context) {
    if (widget._activity.objectives.isEmpty) {
      return _buildBox(
          context,
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('OBJETIVOS:', style: textStyleFS16FWb),
              Text('No hay elementos', style: textStyleFS16),
            ],
          ));
    }
    return _buildBox(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('OBJETIVOS:', style: textStyleFS16FWb),
            SizedBox(
              height: 240,
              child: ListView.builder(
                  itemCount: widget._activity.objectives.length,
                  padding: const EdgeInsets.symmetric(
                      vertical: lowPadding, horizontal: 0),
                  itemBuilder: (context, index) => _listTileName(
                      context, widget._activity.objectives[index].name)),
            ),
          ],
        ));
  }

  Widget _buildProcesses(BuildContext context) {
    if (widget._activity.processes.isEmpty) {
      return _buildBox(
          context,
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PROCESOS:', style: textStyleFS16FWb),
              Text('No hay elementos', style: textStyleFS16),
            ],
          ));
    }
    return _buildBox(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('PROCESOS:', style: textStyleFS16FWb),
            SizedBox(
              height: 240,
              child: ListView.builder(
                  itemCount: widget._activity.processes.length,
                  padding: const EdgeInsets.symmetric(
                      vertical: lowPadding, horizontal: 0),
                  itemBuilder: (context, index) => _listTileName(
                      context, widget._activity.processes[index].name)),
            ),
          ],
        ));
  }

  Widget _buildParticipants(BuildContext context) {
    if (widget._activity.participants.isEmpty) {
      return _buildBox(
          context,
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PARTICIPANTES:', style: textStyleFS16FWb),
              Text('No hay elementos', style: textStyleFS16),
            ],
          ));
    }
    return _buildBox(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('PARTICIPANTES:', style: textStyleFS16FWb),
            SizedBox(
              height: 240,
              child: ListView.builder(
                  itemCount: widget._activity.participants.length,
                  padding: const EdgeInsets.symmetric(
                      vertical: lowPadding, horizontal: 0),
                  itemBuilder: (context, index) => _listTileName(
                      context, widget._activity.participants[index].name)),
            ),
          ],
        ));
  }

  Widget _buildExternalParticipants(BuildContext context) {
    if (widget._activity.externalParticipants.isEmpty) {
      return _buildBox(
          context,
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PARTICIPANTES EXTERNOS:', style: textStyleFS16FWb),
              Text('No hay elementos', style: textStyleFS16),
            ],
          ));
    }
    return _buildBox(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('PARTICIPANTES EXTERNOS:', style: textStyleFS16FWb),
            SizedBox(
              height: 240,
              child: ListView.builder(
                  itemCount: widget._activity.externalParticipants.length,
                  padding: const EdgeInsets.symmetric(
                      vertical: lowPadding, horizontal: 0),
                  itemBuilder: (context, index) => _listTileName(context,
                      widget._activity.externalParticipants[index].name)),
            ),
          ],
        ));
  }

  Widget _listTileName(BuildContext context, String name) {
    return Container(
        padding: const EdgeInsets.all(lowPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(mediumPadding),
          color: secondaryColor,
        ),
        child: Text(name, style: textStyleFS16));
  }

  Widget _buildChecks(BuildContext context) {
    return _buildBox(
      context,
      Column(children: [
        _buildCheckBox(context, 'Controlada', widget._activity.controlActivity),
        _buildCheckBox(context, 'Reunión', widget._activity.meeting),
        _buildCheckBox(
            context, 'Videoconferencia', widget._activity.videoConference),
        _buildCheckBox(context, 'Extraplan', widget._activity.extraPlan),
        _buildCheckBox(context, 'Puntualizada', widget._activity.punctuated),
      ]),
    );
  }

  _buildCheckBox(context, label, checkValue) {
    return CheckboxListTile(
      title: Text(label),
      value: intToBool(checkValue),
      onChanged: (value) {},
      activeColor: primaryColor,
    );
  }

  Widget _buildBox(BuildContext context, Widget child) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: lowPadding),
        padding: const EdgeInsets.all(mediumPadding),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mediumPadding),
            color: secondaryColor),
        child: child);
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }
}
