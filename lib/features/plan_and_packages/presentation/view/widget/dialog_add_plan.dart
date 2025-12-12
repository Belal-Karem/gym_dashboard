import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/features/plan_and_packages/presentation/manger/cubit/plan_cubit.dart';
import 'package:power_gym/features/plan_and_packages/presentation/view/widget/dialog_add_plan_ui.dart';

class DialogAddPlan extends StatelessWidget {
  const DialogAddPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlanCubit, PlanState>(
      listener: (context, state) {
        if (state is AddPlanLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AddPlanSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
          CustomErrorWidget(errMessage: 'تم إضافة العضو الشتراك!');
          context.read<PlanCubit>().loadPlan();
        } else if (state is AddPlanError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: DialogAddPlanUi(),
    );
  }
}
