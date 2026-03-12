import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/helper/build_error_bar.dart';
import 'package:power_gym/features/trainers/presentation/manger/cubit/trainer_cubit.dart';
import 'package:power_gym/features/trainers/presentation/view/widget/trainer_data_table.dart';

import '../../../../../core/widget/app_loading_widget.dart';

class TrainerData extends StatelessWidget {
  const TrainerData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainerCubit, TrainerState>(
      builder: (context, state) {
        if (state is TrainerLoading) {
          return const Center(child: AppLoadingWidget());
        } else if (state is TrainerLoaded) {
          final trainer = state.trainer;
          return TrainerDataTable(trainer: trainer);
        } else if (state is TrainerError) {
          buildErrorBar(context, state.message);
        } else {
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
