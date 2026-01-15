import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_state.dart';
import 'package:power_gym/features/members/presentation/view/widget/dialog_add_member_ui.dart';

class DialogAddMember extends StatelessWidget {
  const DialogAddMember({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MembersCubit, MembersState>(
      listener: (context, state) {
        if (state is AddMemberLoading) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AddMemberSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إضافة العضو بنجاح!')),
          );
          context.read<MembersCubit>().loadMembers();
        } else if (state is AddMemberError) {
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
