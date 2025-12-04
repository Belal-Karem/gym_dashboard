import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_state.dart';
import 'package:power_gym/features/members/presentation/view/widget/dialog_add_member_ui.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_cubit.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_state.dart';

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
        } else if (state is AddMemberSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إضافة العضو بنجاح!')),
          );
          context.read<SubCubit>().loadSub();
        } else if (state is AddSubError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: DialogAddMemberUi(),
    );
  }
}
