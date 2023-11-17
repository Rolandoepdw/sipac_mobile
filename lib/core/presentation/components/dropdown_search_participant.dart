import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipac_mobile_4/core/domain/participant_cubit/participant_cubit.dart';
import 'package:sipac_mobile_4/core/presentation/components/dynamic_search_select_dropdown.dart';


Widget buildSearchParticipant(
    BuildContext context, List<dynamic> selectedItems, void Function(dynamic) callBack) {
  return BlocBuilder<ParticipantCubit, ParticipantState>(
    builder: (context, state) {
      BlocProvider.of<ParticipantCubit>(context).loadParticipants();
      if (state is ParticipantInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ParticipantsLoaded) {
        return DynamicSearchSelectDropDown.name(
            state.participants, selectedItems, callBack, 'Participantes');
      } else
        return Container();
    },
  );
}
