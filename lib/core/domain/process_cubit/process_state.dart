part of 'process_cubit.dart';

@immutable
abstract class ProcessState {
  const ProcessState();
}

class ProcessInitial extends ProcessState {
  const ProcessInitial();
}

class ProcessesLoaded extends ProcessState {
  final List<Process> processes;

  const ProcessesLoaded(this.processes);
}

class ProcessAdded extends ProcessState {
  final Process process;

  const ProcessAdded(this.process);
}

class ProcessUpdated extends ProcessState {
  final Process process;

  const ProcessUpdated(this.process);
}

class ProcessDeleted extends ProcessState {
  final int processId;

  const ProcessDeleted(this.processId);
}

class ProcessError extends ProcessState {
  final String message;

  const ProcessError(this.message);
}