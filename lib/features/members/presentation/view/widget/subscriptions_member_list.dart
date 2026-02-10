import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/members/presentation/view/widget/display_data_for_history.dart';

class SubscriptionsMemberList extends StatelessWidget {
  const SubscriptionsMemberList({super.key, required this.history});
  final List<MemberSubscriptionModel> history;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              child: Row(
                children: [
                  Text('عدد الشتركات:', style: AppStyle.style20),
                  const SizedBox(width: 5),
                  Text(history.length.toString(), style: AppStyle.style15),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DisplayDataForHistory(
                  label: 'تاريخ البدء',
                  child: history.first.startDate.toString(),
                ),
                DisplayDataForHistory(
                  label: 'تاريخ النتهاء',
                  child: history.first.endDate.toString(),
                ),
                DisplayDataForHistory(
                  label: 'حاله الشتراك',
                  child2: history.first.status.arabicName,
                  style: history.first.status == SubscriptionStatus.active
                      ? const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        )
                      : const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
