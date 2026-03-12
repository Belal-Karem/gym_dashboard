import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/utils/service_locator.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/all_comments_cubit.dart';
import 'package:power_gym/features/home/presentation/view/widget/all_comments_dialog.dart';
import 'package:power_gym/features/home/presentation/view/widget/comment_add_dialog.dart';
import 'package:power_gym/features/home/presentation/view/widget/members_notes_dialog.dart';
import 'package:power_gym/features/members/presentation/view/widget/dialog_add_member.dart';

class ButtonShortcutsSession extends StatelessWidget {
  const ButtonShortcutsSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButtonWidget(
          text: 'اضافة عضو',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(child: DialogAddMember());
              },
            );
          },
        ),
        SizedBox(width: 5),
        ElevatedButtonWidget(
          text: 'اضافة تعليق',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(child: CommentAddDialog());
              },
            );
          },
        ),
        SizedBox(width: 60),
        ElevatedButtonWidget(
          text: 'كل التعليقات',
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => BlocProvider(
                create: (_) => AllCommentsCubit(sl())..load(),
                child: const AllCommentsDialog(),
              ),
            );
          },
        ),
        SizedBox(width: 5),
        ElevatedButtonWidget(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => const MembersNotesDialog(),
            );
          },
          text: 'الملاحظات',
        ),
      ],
    );
  }
}
