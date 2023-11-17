import 'dart:io';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sipac_mobile_4/core/data/data_source/db.dart';
import 'package:sipac_mobile_4/core/data/data_source/dev_http_overrides.dart';
import 'package:sipac_mobile_4/core/data/entities/external_participant.dart';
import 'package:sipac_mobile_4/core/data/entities/internal_leader.dart';
import 'package:sipac_mobile_4/core/data/entities/objective.dart';
import 'package:sipac_mobile_4/core/data/entities/participant.dart';
import 'package:sipac_mobile_4/core/data/entities/process.dart';
import 'package:sipac_mobile_4/core/data/entities/strategy.dart';
import 'package:sipac_mobile_4/core/data/repositories/activity_repository.dart';
import 'package:sipac_mobile_4/core/data/repositories/external_participant_repository.dart';
import 'package:sipac_mobile_4/core/data/repositories/internal_leader_repository.dart';
import 'package:sipac_mobile_4/core/data/repositories/objective_repository.dart';
import 'package:sipac_mobile_4/core/data/repositories/participant_repository.dart';
import 'package:sipac_mobile_4/core/data/repositories/process_repository.dart';
import 'package:sipac_mobile_4/core/data/repositories/strategy_repository.dart';
import 'package:sipac_mobile_4/core/data/user_preferences.dart';
import 'package:sipac_mobile_4/core/domain/activity_cubit/activity_cubit.dart';
import 'package:sipac_mobile_4/core/domain/external_participant_cubit/external_participant_cubit.dart';
import 'package:sipac_mobile_4/core/domain/internal_leader_cubit/internal_leader_cubit.dart';
import 'package:sipac_mobile_4/core/domain/objective_cubit/objective_cubit.dart';
import 'package:sipac_mobile_4/core/domain/participant_cubit/participant_cubit.dart';
import 'package:sipac_mobile_4/core/domain/process_cubit/process_cubit.dart';
import 'package:sipac_mobile_4/core/presentation/pages/entry_point/entry_point.dart';
import 'package:sipac_mobile_4/core/presentation/pages/home/home_page.dart';
import 'package:sipac_mobile_4/core/presentation/pages/login/login_page.dart';
import 'package:sipac_mobile_4/core/styles/theme.dart';
import 'core/domain/strategy_cubit/strategy_cubit.dart';
import 'core/presentation/pages/activities_page/activities_page.dart';
import 'core/presentation/pages/new_activity_form/new_activity_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  UserPreferences userPreferences = UserPreferences();
  await userPreferences.initUserPreferences();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final _database;

  late final _activityRepository;

  late final _externalParticipantRepository;

  late final _internalLeaderRepository;

  late final _objectiveRepository;

  late final _participantRepository;

  late final _processRepository;

  late final _strategyRepository;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    HttpOverrides.global = DevHttpOverrides();

    // Ask for permission
    while (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
    //
    // print(await Permission.storage.status);

// // You can can also directly ask the permission about its status.
//     if (await Permission.storage.isDenied) {
//       // The OS restricts access, for example because of parental controls.
//     }

    // Initializing db
    _database = await DB.db.database;

    // Initializing repositories
    _activityRepository = ActivityRepository(_database);

    _externalParticipantRepository = ExternalParticipantRepository(_database);

    _internalLeaderRepository = InternalLeaderRepository(_database);

    _objectiveRepository = ObjectiveRepository(_database);

    _participantRepository = ParticipantRepository(_database);

    _processRepository = ProcessRepository(_database);

    _strategyRepository = StrategyRepository(_database);

    fillDB();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActivityCubit>(
          create: (context) => ActivityCubit(_activityRepository),
        ),
        BlocProvider<ExternalParticipantCubit>(
          create: (context) =>
              ExternalParticipantCubit(_externalParticipantRepository),
        ),
        BlocProvider<InternalLeaderCubit>(
          create: (context) => InternalLeaderCubit(_internalLeaderRepository),
        ),
        BlocProvider<ObjectiveCubit>(
          create: (context) => ObjectiveCubit(_objectiveRepository),
        ),
        BlocProvider<ParticipantCubit>(
          create: (context) => ParticipantCubit(_participantRepository),
        ),
        BlocProvider<ProcessCubit>(
          create: (context) => ProcessCubit(_processRepository),
        ),
        BlocProvider<StrategyCubit>(
          create: (context) => StrategyCubit(_strategyRepository),
        ),
      ],
      child: CalendarControllerProvider(
        controller: EventController(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SIPACMobile',
          // home: const SIPACNavigationDrawer(),
          // home: LoginPage(),
          routes: {
            'login': (context) => const LoginPage(),
            'home': (context) => const HomePage(),
            'entryPoint': (context) => const EntryPoint(),
            'newActivityForm': (context) => const NewActivityForm(),
            'activitiesPage': (context) => const ActivitiesPage(),
          },
          initialRoute: 'login',
          theme: light,
        ),
      ),
    );
  }

  fillDB() {
    // Create Strategies
    for (int i = 1; i <= 20; i++) {
      StrategyCubit(_strategyRepository).addStrategy(Strategy(
          strategyId: i,
          name: 'Esta es la estrategia para la planificacion anual numero $i'));
    }
    // Create InternalLeader
    for (int i = 1; i <= 20; i++) {
      InternalLeaderCubit(_internalLeaderRepository).addInternalLeader(
          InternalLeader(internalLeaderId: i, name: 'Alan Brito Dulce $i'));
    }
    // Create Objective
    for (int i = 1; i <= 20; i++) {
      ObjectiveCubit(_objectiveRepository).addObjective(Objective(
          objectiveId: i,
          name: 'Este es el objetivo para la planificacion anual numero $i'));
    }
    // Create Process
    for (int i = 1; i <= 20; i++) {
      ProcessCubit(_processRepository).addProcess(Process(
          processId: i,
          name: 'Este es el proceso para la planificacion anual numero $i'));
    }
    // Create Participant
    for (int i = 1; i <= 20; i++) {
      ParticipantCubit(_participantRepository).addParticipant(
          Participant(participantId: i, name: 'Suzana Oria $i'));
    }
    // Create ExternalParticipant
    for (int i = 1; i <= 20; i++) {
      ExternalParticipantCubit(_externalParticipantRepository)
          .addExternalParticipant(ExternalParticipant(
          externalParticipantId: i, name: 'Aquilez Vailo $i'));
    }
  }
}