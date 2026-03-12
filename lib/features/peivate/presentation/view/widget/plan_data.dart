import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/helper/build_error_bar.dart';
import 'package:power_gym/features/peivate/presentation/manger/cubit/private_cubit.dart';
import 'package:power_gym/features/peivate/presentation/view/widget/plan_data_taple.dart';

import '../../../../../core/widget/app_loading_widget.dart';

class PlanData extends StatelessWidget {
  const PlanData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivateCubit, PrivateState>(
      builder: (context, state) {
        if (state is PrivateLoading) {
          return AppLoadingWidget();
        } else if (state is PrivateLoaded) {
          final private = state.private;
          return PrivateDataTaple(private: private);
        } else if (state is PrivateError) {
          buildErrorBar(context, state.message);
        } else {
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
