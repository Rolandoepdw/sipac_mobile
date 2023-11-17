import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipac_mobile_4/core/domain/objective_cubit/objective_cubit.dart';
import 'package:sipac_mobile_4/core/presentation/components/dynamic_search_select_dropdown.dart';

Widget buildSearchObjectives(
    BuildContext context, List<dynamic> selectedItems, void Function(dynamic) callBack) {
  return BlocBuilder<ObjectiveCubit, ObjectiveState>(
    builder: (context, state) {
      BlocProvider.of<ObjectiveCubit>(context).loadObjectives();
      if (state is ObjectiveInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ObjectivesLoaded) {
        return DynamicSearchSelectDropDown.name(
            state.objectives, selectedItems, callBack, 'Objetivos');
      } else {
        return Container();
      }
    },
  );
}
