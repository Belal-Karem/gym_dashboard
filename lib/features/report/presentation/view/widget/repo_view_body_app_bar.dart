import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';

class RepoViewBodyAppBar extends StatelessWidget {
  const RepoViewBodyAppBar({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'عرض تقرير اليوم ${date.day}/${date.month}/${date.year}',
          style: AppStyle.stylebold26,
        ),
        Spacer(),
        ElevatedButtonWidget(
          text: 'يغلق',
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
