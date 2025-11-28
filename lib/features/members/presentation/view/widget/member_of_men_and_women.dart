import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/members_statistics_card.dart';

class MemberOfMenAndWomen extends StatelessWidget {
  const MemberOfMenAndWomen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: MembersStatisticsCard(number: '120', text: 'الرجال'),
          ),
          Expanded(
            child: MembersStatisticsCard(number: '100', text: 'النساء'),
          ),
          Expanded(
            child: MembersStatisticsCard(number: '50', text: 'اطفال'),
          ),
          Expanded(
            child: MembersStatisticsCard(number: '220', text: 'النشط'),
          ),
          Expanded(
            child: MembersStatisticsCard(
              number: '50',
              text: 'منتهي',
              textStyle: TextStyle(fontSize: 15, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
