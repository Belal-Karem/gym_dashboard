import 'package:flutter/material.dart';
import 'package:power_gym/features/payment/presentation/view/widget/top_section_of_payment.dart';
import 'package:power_gym/features/plan_and_packages/presentation/view/widget/plan_data.dart';

class PlanBody extends StatelessWidget {
  const PlanBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الاشتراكات Pt',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          TopSectionOfPayment(),
          SizedBox(height: 15),
          Expanded(child: PlanData()),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
