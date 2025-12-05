import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/features/trainers/presentation/manger/cubit/trainer_cubit.dart';
import 'package:power_gym/features/trainers/presentation/view/widget/trainer_data_table.dart';

class TrainerData extends StatelessWidget {
  const TrainerData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainerCubit, TrainerState>(
      builder: (context, state) {
        if (state is TrainerLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TrainerLoaded) {
          final trainer = state.trainer;
          return TrainerDataTable(trainer: trainer);
        } else if (state is TrainerError) {
          return CustomErrorWidget(errMessage: state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
