import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/features/trainers/presentation/view/widget/top_section_of_trainer.dart';
import 'package:power_gym/features/trainers/presentation/view/widget/trainer_data.dart';

class TrainerBody extends StatelessWidget {
  const TrainerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المدربين',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          TopSectionOfTrainer(),
          SizedBox(height: 15),
          Expanded(child: TrainerData()),
          const SizedBox(height: 30),
          ElevatedButtonWidget(text: 'اضافه مدرب', onPressed: () {}),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
