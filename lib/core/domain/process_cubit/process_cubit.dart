import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sipac_mobile_4/core/data/entities/process.dart';
import 'package:sipac_mobile_4/core/data/repositories/process_repository.dart';


part 'process_state.dart';

class ProcessCubit extends Cubit<ProcessState> {
  final ProcessRepository _processRepository;

  ProcessCubit(this._processRepository) : super(const ProcessInitial());

  Future<void> loadProcesses() async {
    try {
      final processes = await _processRepository.getAll();
      emit(ProcessesLoaded(processes));
    } catch (e) {
      emit(ProcessError('Failed to load processes: $e'));
    }
  }

  Future<void> addProcess(Process process) async {
    try {
      await _processRepository.insert(process);
      emit(ProcessAdded(process));
    } catch (e) {
      emit(ProcessError('Failed to add process: $e'));
    }
  }

  Future<void> updateProcess(Process process) async {
    try {
      await _processRepository.update(process);
      emit(ProcessUpdated(process));
    } catch (e) {
      emit(ProcessError('Failed to update process: $e'));
    }
  }

  Future<void> deleteProcess(int processId) async {
    try {
      await _processRepository.delete(processId);
      emit(ProcessDeleted(processId));
    } catch (e) {
      emit(ProcessError('Failed to delete process: $e'));
    }
  }
}
