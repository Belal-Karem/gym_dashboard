import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/members/presentation/view/widget/custom_dropdown_to_add_member.dart';
import 'package:power_gym/features/members/presentation/view/widget/text_field_add_member.dart';

class DialogAddMember extends StatelessWidget {
  const DialogAddMember({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name', style: AppStyle.style20W500),
          TextFieldAddMember(),
          SizedBox(height: 15),
          Text('Email', style: AppStyle.style20W500),
          TextFieldAddMember(),
          SizedBox(height: 15),
          Text('Phone', style: AppStyle.style20W500),
          TextFieldAddMember(),
          CustomDropdownToAddMember(),
        ],
      ),
    );
  }
}
