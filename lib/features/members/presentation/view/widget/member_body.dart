import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/features/members/presentation/view/widget/dialog_add_member.dart';
import 'package:power_gym/features/members/presentation/view/widget/members_data_table.dart';
import 'package:power_gym/features/members/presentation/view/widget/top_section_of_members.dart';

class MemberBody extends StatelessWidget {
  const MemberBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('أعضاء', style: AppStyle.stylebold26),
          const TopSectionOfMembers(),
          const SizedBox(height: 15),
          Expanded(child: MembersDataTable()),
          const SizedBox(height: 30),
          ElevatedButtonWidget(
            text: 'إضافة عضو',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(child: const DialogAddMember());
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
