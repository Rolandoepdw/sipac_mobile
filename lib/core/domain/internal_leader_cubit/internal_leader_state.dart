part of 'internal_leader_cubit.dart';

@immutable
abstract class InternalLeaderState {
  const InternalLeaderState();
}

class InternalLeaderInitial extends InternalLeaderState {
  const InternalLeaderInitial();
}

class InternalLeadersLoaded extends InternalLeaderState {
  final List<InternalLeader> internalLeaders;

  const InternalLeadersLoaded(this.internalLeaders);
}

class InternalLeaderAdded extends InternalLeaderState {
  final InternalLeader internalLeader;

  const InternalLeaderAdded(this.internalLeader);
}

class InternalLeaderUpdated extends InternalLeaderState {
  final InternalLeader internalLeader;

  const InternalLeaderUpdated(this.internalLeader);
}

class InternalLeaderDeleted extends InternalLeaderState {
  final int internalLeaderId;

  const InternalLeaderDeleted(this.internalLeaderId);
}

class InternalLeaderError extends InternalLeaderState {
  final String message;

  const InternalLeaderError(this.message);
}
