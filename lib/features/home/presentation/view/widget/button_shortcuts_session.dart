import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_gym/features/home/presentation/view/widget/button_shortcuts.dart';
import 'package:power_gym/features/home/presentation/view/widget/comment_add_dialog.dart';
import 'package:power_gym/features/members/presentation/view/widget/dialog_add_member.dart';

class ButtonShortcutsSession extends StatelessWidget {
  const ButtonShortcutsSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
      ],
    );
  }
}
