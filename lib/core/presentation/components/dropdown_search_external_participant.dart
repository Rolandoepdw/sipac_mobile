import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipac_mobile_4/core/domain/external_participant_cubit/external_participant_cubit.dart';
import 'package:sipac_mobile_4/core/presentation/components/dynamic_search_select_dropdown.dart';


Widget buildSearchExternalParticipants(
    BuildContext context, List<dynamic> selectedItems, void Function(dynamic) callBack) {
  return BlocBuilder<ExternalParticipantCubit, ExternalParticipantState>(
    builder: (context, state) {
      BlocProvider.of<ExternalParticipantCubit>(context)
          .loadExternalParticipants();
      if (state is ExternalParticipantInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ExternalParticipantsLoaded) {
        return DynamicSearchSelectDropDown.name(
            state.externalParticipants, selectedItems, callBack, 'Participantes externos');
      } else
        return Container();
    },
  );
}
