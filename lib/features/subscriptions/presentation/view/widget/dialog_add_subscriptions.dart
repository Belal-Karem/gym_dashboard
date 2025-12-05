import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
// import 'package:power_gym/features/members/presentation/manger/cubit/member_state.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_cubit.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_state.dart';
import 'package:power_gym/features/subscriptions/presentation/view/widget/dialog_add_subscriptions_ui.dart';

class DialogAddSubscriptions extends StatelessWidget {
  const DialogAddSubscriptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubCubit, SubState>(
      listener: (context, state) {
        if (state is AddSubLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AddSubSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
          CustomErrorWidget(errMessage: 'تم إضافة العضو الشتراك!');
          context.read<SubCubit>().loadSub();
        } else if (state is AddSubError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: DialogAddSubscriptionsUi(),
    );
  }
}
