import 'dart:ui';

import 'package:sipac_mobile_4/core/data/entities/activity.dart';
import 'package:sipac_mobile_4/core/data/entities/external_participant.dart';
import 'package:sipac_mobile_4/core/data/entities/internal_leader.dart';
import 'package:sipac_mobile_4/core/data/entities/objective.dart';
import 'package:sipac_mobile_4/core/data/entities/participant.dart';
import 'package:sipac_mobile_4/core/data/entities/process.dart';
import 'package:sipac_mobile_4/core/data/entities/strategy.dart';
import 'package:sipac_mobile_4/core/data/repositories/internal_leader_repository.dart';
import 'package:sipac_mobile_4/core/data/repositories/strategy_repository.dart';
import 'package:sqflite/sqflite.dart';

class ActivityRepository {
  final Database _database;

  ActivityRepository(this._database);

  //------------------------------- Select query -------------------------------

  Future<Activity?> getById(int activityId) async {
    final result = await _database
        .query('Activity', where: 'activityId = ?', whereArgs: [activityId]);

    if (result.first.isNotEmpty) {
      Map<String, dynamic> activityData = result.first;

      final Strategy? strategy =
          await StrategyRepository(_database).getById(activityData['strategy']);

      final InternalLeader? internalLeader =
          await InternalLeaderRepository(_database)
              .getById(activityData['internalLeader']);

      final List<Objective> objectives =
          await getObjectivesByActivity(activityData['activityId']);

      final List<Process> processes =
          await getProcessesByActivity(activityData['activityId']);

      final List<Participant> participants =
          await getParticipantsByActivity(activityData['activityId']);

      final List<ExternalParticipant> externalParticipants =
          await getExternalParticipantsByActivity(activityData['activityId']);

      return Activity(
        activityId: activityData['activityId'],
        activityColor: Color(activityData['activityColor']),
        generalActivityId: activityData['generalActivityId'],
        denomination: activityData['denomination'],
        startDate: DateTime.parse(activityData['startDate']),
        endDate: DateTime.parse(activityData['endDate']),
        place: activityData['place'],
        strategy: strategy,
        internalLeader: internalLeader,
        externalLeader: activityData['externalLeader'],
        videoConference: activityData['videoConference'],
        controlActivity: activityData['controlActivity'],
        punctuated: activityData['punctuated'],
        extraPlan: activityData['extraPlan'],
        meeting: activityData['meeting'],
        objectives: objectives,
        processes: processes,
        participants: participants,
        externalParticipants: externalParticipants,
      );
    } else {
      return null;
    }
  }

  Future<List<Activity>> getAll() async {
    final List<Map<String, dynamic>> activitiesResult =
        await _database.query('Activity');

    List<Activity> activities = [];

    for (final activityData in activitiesResult) {
      final Strategy? strategy =
          await StrategyRepository(_database).getById(activityData['strategy']);

      final InternalLeader? internalLeader =
          await InternalLeaderRepository(_database)
              .getById(activityData['internalLeader']);

      final List<Objective> objectives =
          await getObjectivesByActivity(activityData['activityId']);

      final List<Process> processes =
          await getProcessesByActivity(activityData['activityId']);

      final List<Participant> participants =
          await getParticipantsByActivity(activityData['activityId']);

      final List<ExternalParticipant> externalParticipants =
          await getExternalParticipantsByActivity(activityData['activityId']);

      activities.add(Activity(
        activityId: activityData['activityId'],
        activityColor: Color(activityData['activityColor']),
        generalActivityId: activityData['generalActivityId'],
        denomination: activityData['denomination'],
        startDate: DateTime.parse(activityData['startDate']),
        endDate: DateTime.parse(activityData['endDate']),
        place: activityData['place'],
        strategy: strategy,
        internalLeader: internalLeader,
        externalLeader: activityData['externalLeader'],
        videoConference: activityData['videoConference'],
        controlActivity: activityData['controlActivity'],
        punctuated: activityData['punctuated'],
        extraPlan: activityData['extraPlan'],
        meeting: activityData['meeting'],
        objectives: objectives,
        processes: processes,
        participants: participants,
        externalParticipants: externalParticipants,
      ));
    }
    return activities;
  }

  //------------------------------- Insert query -------------------------------

  Future<int> insert(Activity activity) async {
    final result = await _database.insert('Activity', activity.toJson());

    if (activity.objectives.isNotEmpty) {
      for (Objective objective in activity.objectives) {
        await _database.insert('ActivityObjective',
            {'ActivityId': result, 'ObjectiveId': objective.objectiveId});
      }
    }
    if (activity.processes.isNotEmpty) {
      for (Process process in activity.processes) {
        await _database.insert('ActivityProcess',
            {'ActivityId': result, 'ProcessId': process.processId});
      }
    }

    if (activity.participants.isNotEmpty) {
      for (Participant participant in activity.participants) {
        await _database.insert('ActivityParticipant',
            {'ActivityId': result, 'ParticipantId': participant.participantId});
      }
    }

    if (activity.externalParticipants.isNotEmpty) {
      for (ExternalParticipant externalParticipant
          in activity.externalParticipants) {
        await _database.insert('ActivityExternalParticipant', {
          'ActivityId': result,
          'ExternalParticipantId': externalParticipant.externalParticipantId
        });
      }
    }
    return result;
  }

  //------------------------------- Update query -------------------------------

  Future<int> update(Activity activity) async {
    // Delete old relationships in ActivityObjective table
    await _database.delete(
      'ActivityObjective',
      where: 'activityId = ?',
      whereArgs: [activity.activityId],
    );

    // Insert the new relationships into the ActivityObjective table
    for (Objective objective in activity.objectives) {
      await _database.insert('ActivityObjective', {
        'activityId': activity.activityId,
        'objectiveId': objective.objectiveId,
      });
    }

    // Delete old relationships in ActivityProcess table
    await _database.delete(
      'ActivityProcess',
      where: 'activityId = ?',
      whereArgs: [activity.activityId],
    );

    // Insert the new relationships into the ActivityObjective table
    for (Process process in activity.processes) {
      await _database.insert('ActivityProcess', {
        'activityId': activity.activityId,
        'processId': process.processId,
      });
    }

    // Delete old relationships in ActivityParticipant table
    await _database.delete(
      'ActivityParticipant',
      where: 'activityId = ?',
      whereArgs: [activity.activityId],
    );

    // Insert the new relationships into the ActivityParticipant table
    for (Participant participant in activity.participants) {
      await _database.insert('ActivityParticipant', {
        'activityId': activity.activityId,
        'participantId': participant.participantId,
      });
    }

    // Delete old relationships in ActivityExternalParticipant table
    await _database.delete(
      'ActivityObjective',
      where: 'activityId = ?',
      whereArgs: [activity.activityId],
    );

    // Insert the new relationships into the ActivityExternalParticipant table
    for (ExternalParticipant externalParticipant
        in activity.externalParticipants) {
      await _database.insert('ActivityExternalParticipant', {
        'activityId': activity.activityId,
        'externalParticipantId': externalParticipant.externalParticipantId,
      });
    }

    return await _database.update(
        'Activity',
        where: 'activityId = ?',
        whereArgs: [activity.activityId],
        activity.toJson());
  }

  //------------------------------- Delete query -------------------------------

  Future<int> delete(Activity activity) async {
    if (activity.objectives.isNotEmpty) {
      await _database.delete('ActivityObjective',
          where: 'activityId = ?', whereArgs: [activity.activityId]);
    }

    if (activity.processes.isNotEmpty) {
      await _database.delete('ActivityProcess',
          where: 'activityId = ?', whereArgs: [activity.activityId]);
    }

    if (activity.participants.isNotEmpty) {
      await _database.delete('ActivityParticipant',
          where: 'activityId = ?', whereArgs: [activity.activityId]);
    }

    if (activity.externalParticipants.isNotEmpty) {
      await _database.delete('ActivityExternalParticipant',
          where: 'activityId = ?', whereArgs: [activity.activityId]);
    }

    return await _database.delete('Activity',
        where: 'activityId = ?', whereArgs: [activity.activityId]);
  }

  //--------------------------------- m-m query --------------------------------

  Future<List<Objective>> getObjectivesByActivity(int activityId) async {
    final result = await _database.rawQuery(
        'SELECT Objective.* FROM Objective INNER JOIN ActivityObjective ON '
        'ActivityObjective.objectiveId = Objective.objectiveId INNER JOIN '
        'Activity ON ActivityObjective.activityId = Activity.activityId '
        'WHERE Activity.activityId = $activityId');
    List<Objective> list = result.isNotEmpty
        ? result.map((e) => Objective.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<Process>> getProcessesByActivity(int activityId) async {
    final result = await _database
        .rawQuery('SELECT Process.* FROM Process INNER JOIN ActivityProcess ON '
            'ActivityProcess.processId = Process.processId INNER JOIN '
            'Activity ON ActivityProcess.activityId = Activity.activityId '
            'WHERE Activity.activityId = $activityId');
    List<Process> list = result.isNotEmpty
        ? result.map((e) => Process.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<Participant>> getParticipantsByActivity(int activityId) async {
    final result = await _database.rawQuery(
        'SELECT Participant.* FROM Participant INNER JOIN ActivityParticipant ON '
        'ActivityParticipant.participantId = Participant.participantId INNER JOIN '
        'Activity ON ActivityParticipant.activityId = Activity.activityId '
        'WHERE Activity.activityId = $activityId');
    List<Participant> list = result.isNotEmpty
        ? result.map((e) => Participant.fromJson(e)).toList()
        : [];
    return list;
  }

  Future<List<ExternalParticipant>> getExternalParticipantsByActivity(
      int activityId) async {
    final result = await _database.rawQuery(
        'SELECT ExternalParticipant.* FROM ExternalParticipant INNER JOIN ActivityExternalParticipant ON '
        'ActivityExternalParticipant.externalParticipantId = ExternalParticipant.externalParticipantId INNER JOIN '
        'Activity ON ActivityExternalParticipant.activityId = Activity.activityId '
        'WHERE Activity.activityId = $activityId');
    List<ExternalParticipant> list = result.isNotEmpty
        ? result.map((e) => ExternalParticipant.fromJson(e)).toList()
        : [];
    return list;
  }
}
