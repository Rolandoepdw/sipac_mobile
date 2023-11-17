part of 'participant_cubit.dart';

@immutable
abstract class ParticipantState {
  const ParticipantState();
}

class ParticipantInitial extends ParticipantState {
  const ParticipantInitial();
}

class ParticipantsLoaded extends ParticipantState {
  final List<Participant> participants;

  const ParticipantsLoaded(this.participants);
}

class ParticipantAdded extends ParticipantState {
  final Participant participant;

  const ParticipantAdded(this.participant);
}

class ParticipantUpdated extends ParticipantState {
  final Participant participant;

  const ParticipantUpdated(this.participant);
}

class ParticipantDeleted extends ParticipantState {
  final int participantId;

  const ParticipantDeleted(this.participantId);
}

class ParticipantError extends ParticipantState {
  final String message;

  const ParticipantError(this.message);
}
