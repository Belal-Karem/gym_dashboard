import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/field_label_and_input_add_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/report/data/models/model/daily_report_comment.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_report_comment_cubit.dart';

class CommentAddDialogUi extends StatelessWidget {
  const CommentAddDialogUi({
    super.key,
    this.comment,
    required this.dateId,
    required this.commentController,
  });

  final DailyReportComment? comment;
  final String dateId;
  final TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment == null ? 'إضافة ملاحظة' : 'تعديل الملاحظة',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          FieldLabelAndInputAddWidget(
            label: 'الملاحظة',
            child: TextFieldAddWidget(controller: commentController),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ❌ Cancel
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إلغاء'),
              ),

              // 🗑 Delete (لو فيه comment)
              if (comment != null)
                TextButton(
                  onPressed: () {
                    context.read<DailyReportCommentCubit>().deleteComment(
                      comment!.date,
                    );

                    Navigator.pop(context);
                  },
                  child: const Text('حذف', style: TextStyle(color: Colors.red)),
                ),

              const SizedBox(width: 8),

              // 💾 Save (Add / Edit)
              ElevatedButton(
                onPressed: () {
                  if (commentController.text.trim().isEmpty) return;

                  context.read<DailyReportCommentCubit>().addOrUpdateComment(
                    DailyReportComment(
                      date: dateId,
                      comment: commentController.text.trim(),
                      updatedAt: DateTime.now(),
                    ),
                  );

                  Navigator.pop(context);
                },
                child: const Text('حفظ'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
