import 'package:flutter/material.dart';
import 'package:power_gym/features/plan_and_packages/presentation/view/widget/plan_view_body.dart';

class PlanView extends StatelessWidget {
  const PlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/image/image.png', height: 120, width: 120),
              Text('Power House Gym', style: TextStyle(fontSize: 20)),
            ],
          ),
          PlanViewBody(),
        ],
      ),
    );
  }
}
