import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';

class MemberDialog extends StatefulWidget {
  final MemberModel member;

  const MemberDialog({super.key, required this.member});

  @override
  State<MemberDialog> createState() => _MemberDialogState();
}

class _MemberDialogState extends State<MemberDialog> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController startController;
  late TextEditingController endController;
  late TextEditingController attendanceController;
  late TextEditingController absenceController;
  late TextEditingController statusController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.member.name);
    phoneController = TextEditingController(text: widget.member.phone);
    startController = TextEditingController(text: widget.member.startdata);
    endController = TextEditingController(text: widget.member.enddata);
    attendanceController = TextEditingController(
      text: widget.member.attendance,
    );
    absenceController = TextEditingController(text: widget.member.absence);
    statusController = TextEditingController(text: widget.member.status);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    startController.dispose();
    endController.dispose();
    attendanceController.dispose();
    absenceController.dispose();
    statusController.dispose();
    super.dispose();
  }

  void updateMember() {
    final updatedMember = widget.member.copyWith(
      name: nameController.text,
      phone: phoneController.text,
      startdata: startController.text,
      enddata: endController.text,
      attendance: attendanceController.text,
      absence: absenceController.text,
      status: statusController.text,
    );

    BlocProvider.of<MembersCubit>(
      context,
    ).updateMember(updatedMember.id, updatedMember.toJson());
    Navigator.pop(context);
  }

  void deleteMember() {
    BlocProvider.of<MembersCubit>(context).deleteMember(widget.member.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('تعديل بيانات العضو'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'الاسم'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'الهاتف'),
            ),
            TextField(
              controller: startController,
              decoration: const InputDecoration(labelText: 'تاريخ البدء'),
            ),
            TextField(
              controller: endController,
              decoration: const InputDecoration(labelText: 'تاريخ الانتهاء'),
            ),
            TextField(
              controller: attendanceController,
              decoration: const InputDecoration(labelText: 'الحضور'),
            ),
            TextField(
              controller: absenceController,
              decoration: const InputDecoration(labelText: 'الغياب'),
            ),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(labelText: 'الحالة'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: deleteMember,
          child: const Text('حذف', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: updateMember,
          child: const Text('تحديث', style: TextStyle(color: Colors.blue)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إغلاق'),
        ),
      ],
    );
  }
}
