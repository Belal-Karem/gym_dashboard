import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/utils/constants.dart';
import 'package:power_gym/core/widget/custom_dropdown_widget.dart';
import 'package:power_gym/core/widget/field_label_and_input_add_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
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
  String? selectedStautu;
  String? selectedGender;

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
    selectedStautu = widget.member.status;
    selectedGender = widget.member.gender;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    startController.dispose();
    endController.dispose();
    attendanceController.dispose();
    absenceController.dispose();
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
      status: selectedStautu ?? widget.member.status,
      gender: selectedGender ?? widget.member.gender,
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
      backgroundColor: kprimaryColor,
      title: const Text('تعديل بيانات العضو'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FieldLabelAndInputAddWidget(
              label: 'الاسم',
              child: TextFieldAddWidget(controller: nameController),
            ),
            FieldLabelAndInputAddWidget(
              label: 'الهاتف',
              child: TextFieldAddWidget(controller: phoneController),
            ),
            FieldLabelAndInputAddWidget(
              label: 'تاريخ البدء',
              child: TextFieldAddWidget(controller: startController),
            ),
            FieldLabelAndInputAddWidget(
              label: 'تاريخ الانتهاء',
              child: TextFieldAddWidget(controller: endController),
            ),
            FieldLabelAndInputAddWidget(
              label: 'الغياب',
              child: TextFieldAddWidget(controller: absenceController),
            ),
            FieldLabelAndInputAddWidget(
              label: 'الحالة',
              child: CustomDropdownWidget(
                items: [
                  DropdownMenuItem(value: 'نشط', child: Text('نشط')),
                  DropdownMenuItem(value: 'متوقف', child: Text('متوقف')),
                ],
                initialValue: selectedStautu,
                onChanged: (value) {
                  setState(() => selectedStautu = value);
                },
              ),
            ),
            FieldLabelAndInputAddWidget(
              label: 'النوع',
              child: CustomDropdownWidget(
                items: [
                  DropdownMenuItem(value: 'ذكر', child: Text('ذكر')),
                  DropdownMenuItem(value: 'أنثى', child: Text('أنثى')),
                  DropdownMenuItem(value: 'طفل', child: Text('طفل')),
                ],
                initialValue: selectedGender,
                onChanged: (value) {
                  setState(() => selectedGender = value);
                },
              ),
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
