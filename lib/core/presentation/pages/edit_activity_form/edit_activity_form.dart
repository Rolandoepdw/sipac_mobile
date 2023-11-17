import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipac_mobile_4/core/data/entities/activity.dart';
import 'package:sipac_mobile_4/core/data/entities/external_participant.dart';
import 'package:sipac_mobile_4/core/data/entities/internal_leader.dart';
import 'package:sipac_mobile_4/core/data/entities/objective.dart';
import 'package:sipac_mobile_4/core/data/entities/participant.dart';
import 'package:sipac_mobile_4/core/data/entities/process.dart';
import 'package:sipac_mobile_4/core/data/entities/strategy.dart';
import 'package:sipac_mobile_4/core/domain/activity_cubit/activity_cubit.dart';
import 'package:sipac_mobile_4/core/presentation/components/brush_color_picker.dart';
import 'package:sipac_mobile_4/core/presentation/components/date_range_piker.dart';
import 'package:sipac_mobile_4/core/presentation/components/dropdown_search_external_participant.dart';
import 'package:sipac_mobile_4/core/presentation/components/dropdown_search_internal_leader.dart';
import 'package:sipac_mobile_4/core/presentation/components/dropdown_search_objective.dart';
import 'package:sipac_mobile_4/core/presentation/components/dropdown_search_participant.dart';
import 'package:sipac_mobile_4/core/presentation/components/dropdown_search_process.dart';
import 'package:sipac_mobile_4/core/presentation/components/dropdown_search_strategy.dart';
import 'package:sipac_mobile_4/core/presentation/components/elegent_notification_manager.dart';
import 'package:sipac_mobile_4/core/presentation/components/my_text_form_field.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';
import 'package:sipac_mobile_4/core/utils/activity_to_calendar_event.dart';
import 'package:sipac_mobile_4/core/utils/date_utils.dart';
import 'package:sipac_mobile_4/core/utils/utils.dart';
import 'package:sipac_mobile_4/core/utils/validators.dart';

class EditActivityForm extends StatefulWidget {
  final Activity _activity;

  const EditActivityForm(this._activity, {Key? key}) : super(key: key);

  @override
  State<EditActivityForm> createState() => _EditActivityFormState(_activity);
}

class _EditActivityFormState extends State<EditActivityForm> {
  final _formLoginKey = GlobalKey<FormState>();

  late final Activity _activity;

  late Color _color;

  late TextEditingController _nomination;
  late TextEditingController _place;
  late TextEditingController _externalLeader;

  late DateTime? _startDate;
  late DateTime? _endDate;

  void _selectStartDate(DateTime? value) => _startDate = value;

  void _selectEndDate(DateTime? value) => _endDate = value;

  late bool _controlActivity;
  late bool _meeting;
  late bool _videoConference;
  late bool _punctuated;
  late bool _extraPlan;

  void _selectControlActivity(bool? value) =>
      setState(() => _controlActivity = value ?? false);

  void _selectMeeting(bool? value) => setState(() => _meeting = value ?? false);

  void _selectVideoconference(bool? value) =>
      setState(() => _videoConference = value ?? false);

  void _selectExtraPlan(bool? value) => setState(() {
        _extraPlan = value ?? false;
        if (value ?? false) _punctuated = false;
      });

  void _selectPunctuated(bool? value) => setState(() {
        _punctuated = value ?? false;
        if (value ?? false) _extraPlan = false;
      });

  late Strategy _selectedStrategy;
  late InternalLeader _selectedInternalLeader;
  late List<dynamic> _selectedObjectives;
  late List<dynamic> _selectedProcesses;
  late List<dynamic> _selectedParticipants;
  late List<dynamic> _selectedExternalParticipants;

  void _selectStrategy(value) => _selectedStrategy = value;

  void _selectInternalLeader(value) => _selectedInternalLeader = value;

  void _selectObjectives(value) => _selectedObjectives = value;

  void _selectProcesses(value) => _selectedProcesses = value;

  void _selectParticipants(value) => _selectedParticipants = value;

  void _selectExternalParticipants(value) =>
      _selectedExternalParticipants = value;

  // this variable determines whether the back-to-top button is shown or not
  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;

  _EditActivityFormState(this._activity) {
    _color = _activity.activityColor;

    _nomination = TextEditingController()..text = _activity.denomination;
    _place = TextEditingController()..text = _activity.place;
    _externalLeader = TextEditingController()..text = _activity.externalLeader;

    _startDate = _activity.startDate;
    _endDate = _activity.endDate;

    _controlActivity = intToBool(_activity.controlActivity);
    _meeting = intToBool(_activity.meeting);
    _videoConference = intToBool(_activity.videoConference);
    _punctuated = intToBool(_activity.punctuated);
    _extraPlan = intToBool(_activity.extraPlan);

    _selectedStrategy = _activity.strategy!;
    _selectedInternalLeader = _activity.internalLeader!;
    _selectedObjectives = _activity.objectives;
    _selectedProcesses = _activity.processes;
    _selectedParticipants = _activity.participants;
    _selectedExternalParticipants = _activity.externalParticipants;
  }

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
      body: _buildForm(context),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formLoginKey,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              margin: const EdgeInsets.all(lowPadding),
              padding: const EdgeInsets.all(lowPadding),
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(highRadius)),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: highPadding),
                  _buildNomination(),
                  DateRangePiker(
                      _activity.startDate,
                      _activity.endDate,
                      0,
                      primaryColor,
                      secondaryColor,
                      false,
                      _selectStartDate,
                      _selectEndDate),
                  const SizedBox(height: lowPadding),
                  _buildPlace(),
                  buildSearchStrategy(context, _selectStrategy),
                  buildSearchInternalLeader(context, _selectInternalLeader),
                  _buildExternalLeader(),
                  _buildChecks(),
                  const SizedBox(height: mediumPadding),
                  buildSearchObjectives(
                      context, _selectedObjectives, _selectObjectives),
                  buildSearchProcesses(
                      context, _selectedProcesses, _selectProcesses),
                  buildSearchParticipant(
                      context, _selectedParticipants, _selectParticipants),
                  buildSearchExternalParticipants(
                      context,
                      _selectedExternalParticipants,
                      _selectExternalParticipants),
                  _buildOptionButtons()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(lowPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Editar Actividad',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: primaryColor)),
          BrushColorPicker(_activity.activityColor, _updateColor)
        ],
      ),
    );
  }

  Widget _buildNomination() {
    return MyTextFormField.name(
      _nomination,
      'Denominación',
      TextCapitalization.words,
      TextInputType.name,
      false,
      (value) => textValidator(value, 'nominación'),
    );
  }

  Widget _buildPlace() {
    return MyTextFormField.name(
      _place,
      'Lugar',
      TextCapitalization.words,
      TextInputType.name,
      false,
      (value) => textValidator(value, 'lugar'),
    );
  }

  Widget _buildExternalLeader() {
    return MyTextFormField.name(
      _externalLeader,
      'Lider externo',
      TextCapitalization.words,
      TextInputType.name,
      false,
      (value) => textValidator(value, 'lider'),
    );
  }

  Widget _buildOptionButtons() {
    return Padding(
      padding: const EdgeInsets.all(lowPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildCreateButton(context),
          const SizedBox(width: highPadding),
          _buildCancelButton(context)
        ],
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          if (_startDate == null) {
            errorNotification(context, 'Seleccione la fecha inicial');
          } else if (_endDate == null) {
            errorNotification(context, 'Seleccione la fecha final');
          } else if (_endDate!.isBefore(_startDate!)) {
            errorNotification(
                context, 'La fecha final debe ser posterior a la inicial');
          } else if (_formLoginKey.currentState!.validate()) {
            List<Objective> objectivesList = List.castFrom(_selectedObjectives);
            List<Process> processesList = List.castFrom(_selectedProcesses);
            List<Participant> participantList =
                List.castFrom(_selectedParticipants);
            List<ExternalParticipant> externalParticipantsList =
                List.castFrom(_selectedExternalParticipants);

            Activity activity = Activity(
                activityId: _activity.activityId,
                activityColor: _color,
                generalActivityId: _activity.generalActivityId,
                denomination: _nomination.text,
                startDate: _startDate ?? now,
                endDate: _endDate ?? now,
                place: _place.text,
                strategy: _selectedStrategy,
                internalLeader: _selectedInternalLeader,
                externalLeader: _externalLeader.text,
                objectives: objectivesList,
                processes: processesList,
                participants: participantList,
                externalParticipants: externalParticipantsList,
                controlActivity: boolToInt(_controlActivity),
                extraPlan: boolToInt(_extraPlan),
                meeting: boolToInt(_meeting),
                punctuated: boolToInt(_punctuated),
                videoConference: boolToInt(_videoConference));

            CalendarControllerProvider.of(context)
                .controller
                .remove(convertActivityToCalendarEvent(_activity));
            CalendarControllerProvider.of(context)
                .controller
                .add(convertActivityToCalendarEvent(activity));

            final bloc = BlocProvider.of<ActivityCubit>(context);
            await bloc.updateActivity(activity);
            if (bloc.state is ActivityUpdated) {
              //Para que al regresar a CalendarPage este emitido este estado
              await bloc.loadActivities();
              Navigator.of(context).pop();

              await successNotification(
                  context, 'Actividad modificada correctamente');
            } else if (bloc.state is ActivityError) {
              Navigator.of(context).pop();
              await errorNotification(
                  context, 'No se pudo modificar la actividad');
            }
          }
        },
        child: const Text(' Editar '));
  }

  Widget _buildCancelButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          Navigator.of(context).pop();
        },
        child: const Text('Cancelar'));
  }

  Widget _buildChecks() {
    return Container(
      margin: const EdgeInsets.all(lowPadding),
      padding: const EdgeInsets.all(lowPadding),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(highRadius)),
      child: Column(children: [
        _buildCheckBox(
            context, 'Controlada', _controlActivity, _selectControlActivity),
        _buildCheckBox(context, 'Reunión', _meeting, _selectMeeting),
        _buildCheckBox(context, 'Videoconferencia', _videoConference,
            _selectVideoconference),
        _buildCheckBox(context, 'Extraplan', _extraPlan, _selectExtraPlan),
        _buildCheckBox(context, 'Puntualizada', _punctuated, _selectPunctuated),
      ]),
    );
  }

  _buildCheckBox(context, label, checkValue, callBack) {
    return CheckboxListTile(
      title: Text(label),
      value: checkValue,
      onChanged: callBack,
      activeColor: primaryColor,
    );
  }

  void _updateColor(Color color) => _color = color;

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
