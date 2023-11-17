part of 'external_participant_cubit.dart';

@immutable
abstract class ExternalParticipantState {
  const ExternalParticipantState();
}

class ExternalParticipantInitial extends ExternalParticipantState {
  const ExternalParticipantInitial();
}

class ExternalParticipantsLoaded extends ExternalParticipantState {
  final List<ExternalParticipant> externalParticipants;

  const ExternalParticipantsLoaded(this.externalParticipants);
}

class ExternalParticipantAdded extends ExternalParticipantState {
  final ExternalParticipant externalParticipant;

  const ExternalParticipantAdded(this.externalParticipant);
}

class ExternalParticipantUpdated extends ExternalParticipantState {
  final ExternalParticipant externalParticipant;

  const ExternalParticipantUpdated(this.externalParticipant);
}

class ExternalParticipantDeleted extends ExternalParticipantState {
  final int externalParticipantId;

  const ExternalParticipantDeleted(this.externalParticipantId);
}

class ExternalParticipantError extends ExternalParticipantState {
  final String message;

  const ExternalParticipantError(this.message);
}
