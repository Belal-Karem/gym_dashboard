import 'package:flutter/material.dart';
import 'package:power_gym/features/home/presentation/view/widget/custom_drawer.dart';
import 'package:power_gym/features/trainers/presentation/view/widget/trainer_body.dart';

class TrainerViewBody extends StatelessWidget {
  const TrainerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(flex: 1, child: const CustomDrawer()),
          Expanded(flex: 3, child: const TrainerBody()),
        ],
      ),
    );
  }
}
