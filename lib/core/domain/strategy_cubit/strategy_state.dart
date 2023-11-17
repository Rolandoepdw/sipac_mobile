part of 'strategy_cubit.dart';

@immutable
abstract class StrategyState {
  const StrategyState();
}

class StrategyInitial extends StrategyState {
  const StrategyInitial();
}

class StrategiesLoaded extends StrategyState {
  final List<Strategy> strategies;

  const StrategiesLoaded(this.strategies);
}

class StrategyAdded extends StrategyState {
  final Strategy strategy;

  const StrategyAdded(this.strategy);
}

class StrategyUpdated extends StrategyState {
  final Strategy strategy;

  const StrategyUpdated(this.strategy);
}

class StrategyDeleted extends StrategyState {
  final int strategyId;

  const StrategyDeleted(this.strategyId);
}

class StrategyError extends StrategyState {
  final String message;

  const StrategyError(this.message);
}
