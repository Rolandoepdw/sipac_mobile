import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sipac_mobile_4/core/data/entities/participant.dart';
import 'package:sipac_mobile_4/core/data/repositories/participant_repository.dart';

part 'participant_state.dart';

class ParticipantCubit extends Cubit<ParticipantState> {
  final ParticipantRepository _participantRepository;

  ParticipantCubit(this._participantRepository) : super(const ParticipantInitial());

  Future<void> loadParticipants() async {
    try {
      final participants = await _participantRepository.getParticipants();
      emit(ParticipantsLoaded(participants));
    } catch (e) {
      emit(ParticipantError('Failed to load participants: $e'));
    }
  }

  Future<void> addParticipant(Participant participant) async {
    try {
      await _participantRepository.insertParticipant(participant);
      emit(ParticipantAdded(participant));
    } catch (e) {
      emit(ParticipantError('Failed to add participant: $e'));
    }
  }

  Future<void> updateParticipant(Participant participant) async {
    try {
      await _participantRepository.updateParticipant(participant);
      emit(ParticipantUpdated(participant));
    } catch (e) {
      emit(ParticipantError('Failed to update participant: $e'));
    }
  }

  Future<void> deleteParticipant(int participantId) async {
    try {
      await _participantRepository.deleteParticipant(participantId);
      emit(ParticipantDeleted(participantId));
    } catch (e) {
      emit(ParticipantError('Failed to delete participant: $e'));
    }
  }
}