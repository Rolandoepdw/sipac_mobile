import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipac_mobile_4/core/domain/activity_cubit/activity_cubit.dart';
import 'package:sipac_mobile_4/core/presentation/components/dynamic_search_select_dropdown.dart';

Widget buildSearchActivity(BuildContext context, List<dynamic> selectedItems,
    void Function(dynamic) callBack) {
  BlocProvider.of<ActivityCubit>(context).loadActivities();
  return BlocBuilder<ActivityCubit, ActivityState>(
    builder: (context, state) {
      if (state is ActivityInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ActivitiesLoaded) {
        return DynamicSearchSelectDropDown.name(
            state.activities, selectedItems, callBack, 'Actividades');
      } else {
        return const Center(child: Text('No hay actividades planificadas'));
      }
    },
  );
}
