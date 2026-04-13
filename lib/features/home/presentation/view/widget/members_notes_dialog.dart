import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/helper/format_date_helper.dart';
import 'package:power_gym/features/home/presentation/view/widget/info_card.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';

import '../../../../../core/widget/app_loading_widget.dart';

class MembersNotesDialog extends StatefulWidget {
  const MembersNotesDialog({super.key});

  @override
  State<MembersNotesDialog> createState() => _MembersNotesDialogState();
}

class _MembersNotesDialogState extends State<MembersNotesDialog> {
  late final MembersCubit _membersCubit;
  late Stream<List<MemberModel>> _notesStream;

  @override
  void initState() {
    super.initState();
    _membersCubit = context.read<MembersCubit>();
    _notesStream = _membersCubit.getMembersWithNotes();
  }

  void _retryStream() {
    setState(() {
      _notesStream = _membersCubit.getMembersWithNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ملاحظات الأعضاء'),
      content: SizedBox(
        width: 400,
        height: 500,
        child: StreamBuilder<List<MemberModel>>(
          stream: _notesStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AppLoadingWidget();
            }

            if (snapshot.hasError) {
              return _MembersNotesErrorState(
                message: snapshot.error.toString(),
                onRetry: _retryStream,
              );
            }

            final members = snapshot.data;
            if (members == null || members.isEmpty) {
              return const Center(child: Text('لا توجد ملاحظات'));
            }

            return ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];

                return InfoCard(
                  title: '${member.name} (${member.memberId})',
                  description: member.note ?? '',
                  date: _formatDateSafely(member.noteCreatedAt),
                  onDelete: () {
                    _membersCubit.deleteNote(member.id);
                  },
                  leading: const Icon(Icons.note_alt, color: Colors.blue),
                );
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إغلاق'),
        ),
      ],
    );
  }
}

String _formatDateSafely(Object? value) {
  try {
    return FormatDateHelper.formatDate(value.toString());
  } catch (_) {
    return '';
  }
}

class _MembersNotesErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _MembersNotesErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('حدث خطأ أثناء تحميل الملاحظات'),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          TextButton(onPressed: onRetry, child: const Text('إعادة المحاولة')),
        ],
      ),
    );
  }
}
