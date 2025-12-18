import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/utils/constants.dart';
import 'package:power_gym/core/widget/custom_dropdown_widget.dart';
import 'package:power_gym/core/widget/field_label_and_input_add_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/plan_and_packages/presentation/view/widget/dialog_add_plan.dart';

class MemberUpdateDialog extends StatefulWidget {
  final MemberModel member;

  const MemberUpdateDialog({super.key, required this.member});

  @override
  State<MemberUpdateDialog> createState() => _MemberUpdateDialogState();
}

class _MemberUpdateDialogState extends State<MemberUpdateDialog> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  // late TextEditingController startController;
  // late TextEditingController endController;
  late TextEditingController attendanceController;
  String? selectedStatus;
  String? selectedGender;
  int? attendanceValue = 0;

  @override
  void initState() {
    super.initState();
    attendanceValue = int.tryParse(attendanceController.text) ?? 0;
    nameController = TextEditingController(text: widget.member.name);
    phoneController = TextEditingController(text: widget.member.phone);
    attendanceController = TextEditingController(
      text: widget.member.attendance.toString(),
    );
    selectedStatus = widget.member.status;
    selectedGender = widget.member.gender;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    // startController.dispose();
    // endController.dispose();
    attendanceController.dispose();
    super.dispose();
  }

  void updateMember() {
    final updatedMember = widget.member.copyWith(
      name: nameController.text,
      phone: phoneController.text,
      attendance: attendanceValue,
      status: selectedStatus ?? widget.member.status,
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
            // FieldLabelAndInputAddWidget(
            //   label: 'تاريخ البدء',
            //   child: TextFieldAddWidget(controller: startController),
            // ),
            // FieldLabelAndInputAddWidget(
            //   label: 'تاريخ الانتهاء',
            //   child: TextFieldAddWidget(controller: endController),
            // ),
            FieldLabelAndInputAddWidget(
              label: 'الحضور',
              child: TextFieldAddWidget(controller: attendanceController),
            ),
            FieldLabelAndInputAddWidget(label: 'الغياب', child: Text('')),
            FieldLabelAndInputAddWidget(
              label: 'الحالة',
              child: CustomDropdownWidget(
                items: const [
                  DropdownMenuItem(value: 'نشط', child: Text('نشط')),
                  DropdownMenuItem(value: 'متوقف', child: Text('متوقف')),
                  DropdownMenuItem(
                    value: 'توقف مؤقت',
                    child: Text('توقف مؤقت'),
                  ),
                ],
                initialValue: selectedStatus,
                onChanged: (value) {
                  setState(() => selectedStatus = value);
                },
              ),
            ),
            FieldLabelAndInputAddWidget(
              label: 'النوع',
              child: CustomDropdownWidget(
                items: const [
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
          onPressed: () {
            Navigator.pop(context); // نقفل Dialog العضو
            openAddPlanDialog(context, widget.member); // ✅ نبعت العضو
          },
          child: const Text(
            'اشتراك بريفت',
            style: TextStyle(color: Colors.green),
          ),
        ),
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
