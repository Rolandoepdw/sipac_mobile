import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sipac_mobile_4/core/data/entities/strategy.dart';
import 'package:sipac_mobile_4/core/data/repositories/strategy_repository.dart';


part 'strategy_state.dart';

class StrategyCubit extends Cubit<StrategyState> {
  final StrategyRepository _strategyRepository;

  StrategyCubit(this._strategyRepository)
      : super(const StrategyInitial());

  Future<void> loadStrategies() async {
    try {
      final strategies = await _strategyRepository.getAll();
      emit(StrategiesLoaded(strategies));
    } catch (e) {
      emit(StrategyError('Failed to load strategies: $e'));
    }
  }

  Future<void> addStrategy(Strategy strategy) async {
    try {
      await _strategyRepository.insert(strategy);
      emit(StrategyAdded(strategy));
    } catch (e) {
      emit(StrategyError('Failed to add strategy: $e'));
    }
  }

  Future<void> updateStrategy(Strategy strategy) async {
    try {
      await _strategyRepository.update(strategy);
      emit(StrategyUpdated(strategy));
    } catch (e) {
      emit(StrategyError('Failed to update strategy: $e'));
    }
  }

  Future<void> deleteStrategy(int strategyId) async {
    try {
      await _strategyRepository.delete(strategyId);
      emit(StrategyDeleted(strategyId));
    } catch (e) {
      emit(StrategyError('Failed to delete strategy: $e'));
    }
  }
}