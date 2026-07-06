import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/report/presentation/view/widget/repo_view.dart';

import 'custom_button_date_card.dart';

class DateCard extends StatelessWidget {
  const DateCard({super.key, required this.dayDate});

  final DateTime dayDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kprimaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${dayDate.day} ${_monthToString(dayDate.month)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).width / 70),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RepoView(selectedDate: dayDate),
                  ),
                );
              },
              child: CustomButtonDateCard(),
            ),
          ),
        ],
      ),
    );
  }

  String _monthToString(int month) {
    const months = [
      '',

      'يناير،',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    return months[month];
  }
}
