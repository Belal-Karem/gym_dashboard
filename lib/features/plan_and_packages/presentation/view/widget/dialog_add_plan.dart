import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/plan_and_packages/presentation/manger/cubit/plan_cubit.dart';
import 'package:power_gym/features/plan_and_packages/presentation/view/widget/dialog_add_plan_ui.dart';

void openAddPlanDialog(BuildContext context, MemberModel member) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => BlocListener<PlanCubit, PlanState>(
      listener: (context, state) {
        if (state is AddPlanSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إضافة الاشتراك بنجاح')),
          );
          context.read<PlanCubit>().loadPlan();
        }

        if (state is AddPlanError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: double.maxFinite,
          child: DialogAddPlanUi(member: member),
        ),
      ),
    ),
  );
}
