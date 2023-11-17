import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sipac_mobile_4/core/data/entities/external_participant.dart';
import 'package:sipac_mobile_4/core/data/repositories/external_participant_repository.dart';


part 'external_participant_state.dart';

class ExternalParticipantCubit extends Cubit<ExternalParticipantState> {
  final ExternalParticipantRepository _externalParticipantRepository;

  ExternalParticipantCubit(this._externalParticipantRepository)
      : super(const ExternalParticipantInitial());

  Future<void> loadExternalParticipants() async {
    try {
      final externalParticipants =
      await _externalParticipantRepository.getAll();
      emit(ExternalParticipantsLoaded(externalParticipants));
    } catch (e) {
      emit(ExternalParticipantError('Failed to load external participants: $e'));
    }
  }

  Future<void> addExternalParticipant(ExternalParticipant externalParticipant) async {
    try {
      await _externalParticipantRepository.insert(externalParticipant);
      emit(ExternalParticipantAdded(externalParticipant));
    } catch (e) {
      emit(ExternalParticipantError('Failed to add external participant: $e'));
    }
  }

  Future<void> updateExternalParticipant(ExternalParticipant externalParticipant) async {
    try {
      await _externalParticipantRepository.update(externalParticipant);
      emit(ExternalParticipantUpdated(externalParticipant));
    } catch (e) {
      emit(ExternalParticipantError('Failed to update external participant: $e'));
    }
  }

  Future<void> deleteExternalParticipant(int externalParticipantId) async {
    try {
      await _externalParticipantRepository.delete(externalParticipantId);
      emit(ExternalParticipantDeleted(externalParticipantId));
    } catch (e) {
      emit(ExternalParticipantError('Failed to delete external participant: $e'));
    }
  }
}