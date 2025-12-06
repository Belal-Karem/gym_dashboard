import 'package:flutter/material.dart';
import 'package:power_gym/features/members/presentation/view/widget/select_sup_body.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_cubit.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';

class SelectSup extends StatelessWidget {
  const SelectSup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubCubit, SubState>(
      builder: (context, state) {
        if (state is SubLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SubLoaded) {
          final subs = state.sub;
          return SelectSupBody(subs: subs);
        } else if (state is SubError) {
          return CustomErrorWidget(errMessage: state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
