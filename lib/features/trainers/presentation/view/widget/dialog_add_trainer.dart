import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/features/trainers/presentation/manger/cubit/trainer_cubit.dart';
import 'package:power_gym/features/trainers/presentation/view/widget/dialog_add_trainer_ui.dart';

class DialogAddTrainer extends StatelessWidget {
  const DialogAddTrainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrainerCubit, TrainerState>(
      listener: (context, state) {
        if (state is AddTrainerLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AddTrainerSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
          CustomErrorWidget(errMessage: 'تم إضافة المدرب !');
          context.read<TrainerCubit>().loadTrainer();
        } else if (state is AddTrainerError) {
          Navigator.pop(context);
          CustomErrorWidget(errMessage: state.message);
        }
      },
      child: DialogAddTrainerUi(),
    );
  }
}
