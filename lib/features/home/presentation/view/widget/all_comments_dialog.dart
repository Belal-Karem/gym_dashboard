import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  final comment = state.comments[index];

                  return ListTile(
                    title: Text(comment.comment),
                    subtitle: Text(comment.date),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<AllCommentsCubit>().delete(comment.date);
                      },
                    ),
                  );
                },
              );
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
