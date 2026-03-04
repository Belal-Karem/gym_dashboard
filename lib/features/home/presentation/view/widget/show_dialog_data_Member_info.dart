import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/helper/format_date_helper.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/features/home/presentation/view/widget/list_title_member_info.dart';
import 'package:power_gym/features/home/presentation/view/widget/member_action_buttons.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/model/show_dialog_data_member_Info_model.dart';

class ShowDialogDataMemberInfo extends StatelessWidget {
  const ShowDialogDataMemberInfo({
    super.key,
    required this.member,
    required this.subscription,
  });

  final MemberModel member;
  final MemberSubscriptionModel subscription;

  @override
  Widget build(BuildContext context) {
    final memberInfo = [
      {'اسم': member.name},
      {'هاتف': member.phone},
      {'النوع': member.gender},
      {
        'تاريخ البداية': FormatDateHelper.formatDate(
          subscription.startDate.toString(),
        ),
      },
      {
        'تاريخ الانتهاء': FormatDateHelper.formatDate(
          subscription.endDate.toString(),
        ),
      },
      {'الحضور': '${subscription.attendance}'},
      {
        'دعوة':
            '${subscription.usedInvitations} / ${subscription.totalInvitations}',
      },
      {'تجميد': '${subscription.freeze} أيام'},
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kprimaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('معلومات العضو', style: AppStyle.style20W500),
              const SizedBox(height: 20),

              /// Dynamic Info List
              ...memberInfo.map(
                (item) => ListTitleMemberInfo(
                  showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                    title: item.keys.first,
                    trailing: item.values.first,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              MemberActionButtons(member: member),
            ],
          ),
        ),
      ),
    );
  }
}
