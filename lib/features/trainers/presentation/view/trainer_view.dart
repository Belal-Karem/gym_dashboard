import 'package:flutter/material.dart';
import 'package:power_gym/features/trainers/presentation/view/widget/trainer_view_body.dart';

class TrainerView extends StatelessWidget {
  const TrainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/image/power-house-gym-gudi-malkapur-hyderabad-gyms-16vu3c2eru-removebg-preview.png',
                height: 120,
                width: 120,
              ),
              Text('Power House Gym', style: TextStyle(fontSize: 20)),
            ],
          ),
          TrainerViewBody(),
        ],
      ),
    );
  }
}
