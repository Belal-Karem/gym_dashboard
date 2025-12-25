import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/widget/field_label_and_input_add_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/home/presentation/view/widget/button_shortcuts.dart';
import 'package:power_gym/features/home/presentation/view/widget/notifications.dart';
import 'package:power_gym/features/home/presentation/view/widget/recent_member_home.dart';
import 'package:power_gym/features/home/presentation/view/widget/search_dropdown_widget.dart';
import 'package:power_gym/features/home/presentation/view/widget/Statistics.dart';
import 'package:power_gym/features/home/presentation/view/widget/monthly_in_dashoard.dart';
import 'package:power_gym/features/members/presentation/view/widget/dialog_add_member.dart';

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
              ButtonShortcuts(
                fontAwesomeIcons: FontAwesomeIcons.add,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(child: DialogAddMember());
                    },
                  );
                },
              ),
              SizedBox(width: 5),
              ButtonShortcuts(
                fontAwesomeIcons: FontAwesomeIcons.comment,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(child: CommentAddDialog());
                    },
                  );
                },
              ),
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

class CommentAddDialog extends StatefulWidget {
  const CommentAddDialog({super.key});

  @override
  State<CommentAddDialog> createState() => _CommentAddDialogState();
}

class _CommentAddDialogState extends State<CommentAddDialog> {
  TextEditingController commentAddController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2,
      height: MediaQuery.sizeOf(context).height / 3,
      child: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FieldLabelAndInputAddWidget(
              label: 'أضف ملاحظة',
              child: TextFieldAddWidget(controller: commentAddController),
            ),
          ],
        ),
      ),
    );
  }
}
