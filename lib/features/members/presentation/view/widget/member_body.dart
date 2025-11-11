import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/features/members/presentation/view/widget/recent_member.dart';
import 'package:power_gym/features/members/presentation/view/widget/top_section_of_members.dart';

class MemberBody extends StatelessWidget {
  const MemberBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TopSectionOfMembers(),
          SizedBox(height: 15),
          Expanded(
            child: CustomContainerStatistics(
              padding: 0,
              child: Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(children: [Expanded(child: RecentMember())]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButtonWidget(text: 'إضافة عضو', onPressed: () {}),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
