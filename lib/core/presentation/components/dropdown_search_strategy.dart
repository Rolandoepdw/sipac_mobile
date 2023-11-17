import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipac_mobile_4/core/data/entities/strategy.dart';
import 'package:sipac_mobile_4/core/domain/strategy_cubit/strategy_cubit.dart';
import 'package:sipac_mobile_4/core/presentation/components/dynamic_search_dropdown.dart';

Widget buildSearchStrategy(
    BuildContext context, void Function(Strategy?) callBack) {
  return BlocBuilder<StrategyCubit, StrategyState>(
    builder: (context, state) {
      BlocProvider.of<StrategyCubit>(context).loadStrategies();
      if (state is StrategyInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is StrategiesLoaded) {
        return DynamicDropDownSearch.name(
            state.strategies, callBack, 'Estrategia');
      } else {
        return Container();
      }
    },
  );
}
