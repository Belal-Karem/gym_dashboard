import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/features/home/presentation/view/widget/button_shortcuts_session.dart';
import 'package:power_gym/features/home/presentation/view/widget/notifications.dart';
import 'package:power_gym/features/home/presentation/view/widget/recent_member_home.dart';
import 'package:power_gym/features/home/presentation/view/widget/search_dropdown_widget.dart';
import 'package:power_gym/features/home/presentation/view/widget/Statistics.dart';
import 'package:power_gym/features/home/presentation/view/widget/monthly_in_dashoard.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Text('لوحة التحكم', style: AppStyle.style30w500),
              SizedBox(width: 10),
              ButtonShortcutsSession(),
              Spacer(),
              Container(width: 300, child: SearchDropdownWidget()),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(flex: 3, child: Statistics()),
              Expanded(flex: 3, child: MonthlyInDashoard()),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(child: RecentMemberHome()),
              Expanded(child: Notifications()),
            ],
          ),
        ),
      ],
    );
  }
}
