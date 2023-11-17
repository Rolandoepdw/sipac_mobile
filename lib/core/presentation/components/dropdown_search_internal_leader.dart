import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipac_mobile_4/core/domain/internal_leader_cubit/internal_leader_cubit.dart';
import 'package:sipac_mobile_4/core/presentation/components/dynamic_search_dropdown.dart';


Widget buildSearchInternalLeader(
    BuildContext context, void Function(dynamic) callBack) {
  return BlocBuilder<InternalLeaderCubit, InternalLeaderState>(
    builder: (context, state) {
      BlocProvider.of<InternalLeaderCubit>(context).loadInternalLeaders();
      if (state is InternalLeaderInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is InternalLeadersLoaded) {
        return DynamicDropDownSearch.name(
            state.internalLeaders, callBack, 'Lider interno');
      } else
        return Container();
    },
  );
}
