import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/helper/format_date_helper.dart';
import 'package:power_gym/core/widget/info_card.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';

class MembersNotesDialog extends StatelessWidget {
  const MembersNotesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ملاحظات الأعضاء'),
      content: SizedBox(
        width: 400,
        height: 500,
        child: StreamBuilder<List<MemberModel>>(
          stream: context.read<MembersCubit>().getMembersWithNotes(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('لا توجد ملاحظات'));
            }

            final members = snapshot.data!;

            if (members.isEmpty) {
              return const Center(child: Text('لا توجد ملاحظات'));
            }

            return ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];

                return InfoCard(
                  title: '${member.name} (${member.memberId})',
                  description: member.note ?? '',
                  date: FormatDateHelper.formatDate(
                    member.noteCreatedAt.toString(),
                  ),
                  onDelete: () {
                    context.read<MembersCubit>().deleteNote(member.id);
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
