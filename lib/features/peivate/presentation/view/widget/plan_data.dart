import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/features/peivate/presentation/manger/cubit/private_cubit.dart';
import 'package:power_gym/features/peivate/presentation/view/widget/plan_data_taple.dart';

class PlanData extends StatelessWidget {
  const PlanData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivateCubit, PrivateState>(
      builder: (context, state) {
        if (state is PrivateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PrivateLoaded) {
          final private = state.private;
          return PlanDataTaple(plan: private);
        } else if (state is PrivateError) {
          return CustomErrorWidget(errMessage: state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
