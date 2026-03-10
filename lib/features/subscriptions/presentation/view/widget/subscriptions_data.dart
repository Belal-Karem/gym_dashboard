import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/helper/build_error_bar.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_cubit.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_state.dart';
import 'package:power_gym/features/subscriptions/presentation/view/widget/subscriptions_data_taple.dart';

class SubscriptionsData extends StatelessWidget {
  const SubscriptionsData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubCubit, SubState>(
      builder: (context, state) {
        if (state is SubLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SubLoaded) {
          final subs = state.sub;
          return SubscriptionsDataTaple(subs: subs);
        } else if (state is SubError) {
          buildErrorBar(context, state.message);
        } else {
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
