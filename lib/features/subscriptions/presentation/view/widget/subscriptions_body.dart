import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/subscriptions/presentation/view/widget/dialog_add_subscriptions.dart';
import 'package:power_gym/features/subscriptions/presentation/view/widget/subscriptions_data.dart';
import 'package:power_gym/features/subscriptions/presentation/view/widget/subscriptions_data_taple.dart';
import 'package:power_gym/features/subscriptions/presentation/view/widget/top_section_of_subscriptions.dart';

class SubscriptionsBody extends StatelessWidget {
  const SubscriptionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الاشتركات',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          TopSectionOfSubscriptions(),
          SizedBox(height: 15),
          Expanded(child: SubscriptionsData()),
          const SizedBox(height: 30),
          ElevatedButtonWidget(
            text: 'اضافه اشتراك',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(child: DialogAddSubscriptions());
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
