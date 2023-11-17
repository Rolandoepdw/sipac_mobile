import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipac_mobile_4/core/domain/process_cubit/process_cubit.dart';
import 'package:sipac_mobile_4/core/presentation/components/dynamic_search_select_dropdown.dart';


Widget buildSearchProcesses(
    BuildContext context, List<dynamic> selectedItems, void Function(dynamic) callBack) {
  return BlocBuilder<ProcessCubit, ProcessState>(
    builder: (context, state) {
      BlocProvider.of<ProcessCubit>(context).loadProcesses();
      if (state is ProcessInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ProcessesLoaded) {
        return DynamicSearchSelectDropDown.name(
            state.processes, selectedItems, callBack, 'Procesos');
      } else {
        return Container();
      }
    },
  );
}
