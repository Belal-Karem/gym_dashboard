import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/info_card.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/all_comments_cubit.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/all_comments_state.dart';

class AllCommentsDialog extends StatelessWidget {
  const AllCommentsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("كل التعليقات"),
      content: SizedBox(
        width: 400,
        child: BlocBuilder<AllCommentsCubit, AllCommentsState>(
          builder: (context, state) {
            if (state is AllCommentsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AllCommentsLoaded) {
              if (state.comments.isEmpty) {
                return const Text("لا يوجد تعليقات");
              }

              return AllCommentsDialogUi(comments: state.comments);
            }

            return const SizedBox();
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("إغلاق"),
        ),
      ],
    );
  }
}

class AllCommentsDialogUi extends StatelessWidget {
  const AllCommentsDialogUi({super.key, required this.comments});

  final List comments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];

        return InfoCard(
          title: comment.comment,
          description: '',
          date: comment.date,
          onDelete: () {
            context.read<AllCommentsCubit>().delete(comment.date);
          },
          leading: const Icon(Icons.comment, color: Colors.green),
        );
      },
    );
  }
}
