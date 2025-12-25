import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:power_gym/features/home/presentation/view/widget/comment_add_dialog_ui.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_report_comment_cubit.dart';

class CommentAddDialog extends StatefulWidget {
  const CommentAddDialog({super.key});

  @override
  State<CommentAddDialog> createState() => _CommentAddDialogState();
}

class _CommentAddDialogState extends State<CommentAddDialog> {
  late TextEditingController commentController;

  @override
  void initState() {
    super.initState();
    commentController = TextEditingController();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocBuilder<DailyReportCommentCubit, DailyReportCommentState>(
        builder: (context, state) {
          if (state is DailyReportCommentStateLoading) {
            return const SizedBox(
              height: 150,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is DailyReportCommentStateLoaded) {
            final comment = state.comment;
            final String dateId =
                comment?.date ??
                DateFormat('yyyy-MM-dd').format(DateTime.now());

            if (comment != null && commentController.text.isEmpty) {
              commentController.text = comment.comment;
            }

            return CommentAddDialogUi(
              comment: comment,
              dateId: dateId,
              commentController: commentController,
            );
          }

          if (state is DailyReportCommentStateError) {
            return SizedBox(
              height: 150,
              child: Center(child: Text(state.message)),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
