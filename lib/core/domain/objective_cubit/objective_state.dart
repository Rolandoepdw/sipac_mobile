part of 'objective_cubit.dart';

@immutable
abstract class ObjectiveState {
  const ObjectiveState();
}

class ObjectiveInitial extends ObjectiveState {
  const ObjectiveInitial();
}

class ObjectivesLoaded extends ObjectiveState {
  final List<Objective> objectives;

  const ObjectivesLoaded(this.objectives);
}

class ObjectiveAdded extends ObjectiveState {
  final Objective objective;

  const ObjectiveAdded(this.objective);
}

class ObjectiveUpdated extends ObjectiveState {
  final Objective objective;

  const ObjectiveUpdated(this.objective);
}

class ObjectiveDeleted extends ObjectiveState {
  final int objectiveId;

  const ObjectiveDeleted(this.objectiveId);
}

class ObjectiveError extends ObjectiveState {
  final String message;

  const ObjectiveError(this.message);
}
