import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/data/entities/external_participant.dart';
import 'package:sipac_mobile_4/core/data/entities/internal_leader.dart';
import 'package:sipac_mobile_4/core/data/entities/objective.dart';
import 'package:sipac_mobile_4/core/data/entities/participant.dart';
import 'package:sipac_mobile_4/core/data/entities/process.dart';
import 'package:sipac_mobile_4/core/data/entities/strategy.dart';

Activity activityFromJson(String str) => Activity.fromJson(json.decode(str));

String activityToJson(Activity data) => json.encode(data.toJson());

class Activity {
  int activityId;
  Color activityColor;
  int generalActivityId;
  String denomination;
  DateTime startDate;
  DateTime endDate;
  String place;
  Strategy? strategy;
  InternalLeader? internalLeader;
  String externalLeader;
  int videoConference;
  int controlActivity;
  int punctuated;
  int extraPlan;
  int meeting;
  List<Objective> objectives;
  List<Process> processes;
  List<Participant> participants;
  List<ExternalParticipant> externalParticipants;

  Activity({
    required this.activityId,
    required this.activityColor,
    required this.generalActivityId,
    required this.denomination,
    required this.startDate,
    required this.endDate,
    required this.place,
    required this.strategy,
    required this.internalLeader,
    required this.externalLeader,
    required this.videoConference,
    required this.controlActivity,
    required this.punctuated,
    required this.extraPlan,
    required this.meeting,
    required this.objectives,
    required this.processes,
    required this.participants,
    required this.externalParticipants,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        activityId: json["activityId"],
        activityColor: Color(json["activityColor"]),
        generalActivityId: json["generalActivityId"],
        denomination: json["denomination"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        place: json["place"],
        strategy: json["strategy"],
        internalLeader: json["internalLeader"],
        externalLeader: json["externalLeader"],
        videoConference: json["videoConference"],
        controlActivity: json["controlActivity"],
        punctuated: json["punctuated"],
        extraPlan: json["extraPlan"],
        meeting: json["meeting"],
        objectives: List<Objective>.from(
            ["objectives"].map((x) => objectiveFromJson((x)))),
        processes:
            List<Process>.from(["processes"].map((x) => processFromJson((x)))),
        participants: List<Participant>.from(
            ["participants"].map((x) => participantFromJson(x))),
        externalParticipants: List<ExternalParticipant>.from([
          "externalParticipants"
        ].map((x) => externalParticipantFromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        // "activityId": activityId,
        "activityColor": activityColor.value,
        "generalActivityId": generalActivityId,
        "denomination": denomination,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "place": place,
        "strategy": strategy?.strategyId,
        "internalLeader": internalLeader?.internalLeaderId,
        "externalLeader": externalLeader,
        "videoConference": videoConference,
        "controlActivity": controlActivity,
        "punctuated": punctuated,
        "extraPlan": extraPlan,
        "meeting": meeting,
      };

  @override
  String toString() {
    return denomination;
  }

  @override
  bool operator ==(Object other) =>
      activityId == (other as Activity).activityId;
}
