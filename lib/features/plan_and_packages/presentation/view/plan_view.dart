import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/gradient_scaffold.dart';
import 'package:power_gym/features/home/presentation/view/widget/logo_and_name.dart';
import 'package:power_gym/features/plan_and_packages/presentation/view/widget/plan_view_body.dart';

class PlanView extends StatelessWidget {
  const PlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          Row(children: [LogoAndName()]),
          PlanViewBody(),
        ],
      ),
    );
  }
}
