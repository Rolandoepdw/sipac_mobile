import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sipac_mobile_4/core/data/entities/objective.dart';
import 'package:sipac_mobile_4/core/data/repositories/objective_repository.dart';

part 'objective_state.dart';

class ObjectiveCubit extends Cubit<ObjectiveState> {
  final ObjectiveRepository _objectiveRepository;

  ObjectiveCubit(this._objectiveRepository)
      : super(const ObjectiveInitial());

  Future<void> loadObjectives() async {
    try {
      final objectives = await _objectiveRepository.getAll();
      emit(ObjectivesLoaded(objectives));
    } catch (e) {
      emit(ObjectiveError('Failed to load objectives: $e'));
    }
  }

  Future<void> addObjective(Objective objective) async {
    try {
      await _objectiveRepository.insert(objective);
      emit(ObjectiveAdded(objective));
    } catch (e) {
      emit(ObjectiveError('Failed to add objective: $e'));
    }
  }

  Future<void> updateObjective(Objective objective) async {
    try {
      await _objectiveRepository.update(objective);
      emit(ObjectiveUpdated(objective));
    } catch (e) {
      emit(ObjectiveError('Failed to update objective: $e'));
    }
  }

  Future<void> deleteObjective(int objectiveId) async {
    try {
      await _objectiveRepository.delete(objectiveId);
      emit(ObjectiveDeleted(objectiveId));
    } catch (e) {
      emit(ObjectiveError('Failed to delete objective: $e'));
    }
  }
}