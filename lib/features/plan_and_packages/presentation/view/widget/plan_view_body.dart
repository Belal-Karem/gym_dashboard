import 'package:flutter/material.dart';
import 'package:power_gym/features/home/presentation/view/widget/custom_drawer.dart';
import 'package:power_gym/features/plan_and_packages/presentation/view/widget/plan_body.dart';

class PlanViewBody extends StatelessWidget {
  const PlanViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(flex: 1, child: const CustomDrawer()),
          Expanded(flex: 3, child: const PlanBody()),
        ],
      ),
    );
  }
}
