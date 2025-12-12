import 'package:flutter/material.dart';

import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/features/payment/presentation/view/widget/top_section_of_payment.dart';
import 'package:power_gym/features/plan_and_packages/presentation/view/widget/dialog_add_plan.dart';
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
            'الاشتراكات الخاصة',
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
          ElevatedButtonWidget(
            text: 'اضافه اشتراك',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(child: DialogAddPlan());
                },
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
