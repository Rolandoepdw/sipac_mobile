import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sipac_mobile_4/core/data/entities/internal_leader.dart';
import 'package:sipac_mobile_4/core/data/repositories/internal_leader_repository.dart';

part 'internal_leader_state.dart';

class InternalLeaderCubit extends Cubit<InternalLeaderState> {
  final InternalLeaderRepository _internalLeaderRepository;

  InternalLeaderCubit(this._internalLeaderRepository)
      : super(const InternalLeaderInitial());

  Future<void> loadInternalLeaders() async {
    try {
      final internalLeaders =
      await _internalLeaderRepository.getAll();
      emit(InternalLeadersLoaded(internalLeaders));
    } catch (e) {
      emit(InternalLeaderError('Failed to load internal leaders: $e'));
    }
  }

  Future<void> addInternalLeader(InternalLeader internalLeader) async {
    try {
      await _internalLeaderRepository.insert(internalLeader);
      emit(InternalLeaderAdded(internalLeader));
    } catch (e) {
      emit(InternalLeaderError('Failed to add internal leader: $e'));
    }
  }

  Future<void> updateInternalLeader(InternalLeader internalLeader) async {
    try {
      await _internalLeaderRepository.update(internalLeader);
      emit(InternalLeaderUpdated(internalLeader));
    } catch (e) {
      emit(InternalLeaderError('Failed to update internal leader: $e'));
    }
  }

  Future<void> deleteInternalLeader(int internalLeaderId) async {
    try {
      await _internalLeaderRepository.delete(internalLeaderId);
      emit(InternalLeaderDeleted(internalLeaderId));
    } catch (e) {
      emit(InternalLeaderError('Failed to delete internal leader: $e'));
    }
  }
}
