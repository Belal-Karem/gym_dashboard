import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/elevated_button_to_dialog.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_state.dart';
import 'package:power_gym/features/members/presentation/view/select_sup_view.dart';
import 'package:power_gym/features/members/presentation/view/widget/custom_dropdown_to_add_member.dart';
import 'package:power_gym/features/members/presentation/view/widget/double_field_row.dart';
import 'package:power_gym/features/members/presentation/view/widget/field_label_and_input.dart';
import 'package:power_gym/features/members/presentation/view/widget/text_field_add_member.dart';

class DialogAddMember extends StatelessWidget {
  const DialogAddMember({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MembersCubit, MembersState>(
      listener: (context, state) {
        if (state is AddMemberLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AddMemberSuccess) {
          Navigator.pop(context); // يقفل الـ loading
          Navigator.pop(context); // يقفل الـ dialog
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إضافة العضو بنجاح!')),
          );
          context.read<MembersCubit>().loadMembers();
        } else if (state is AddMemberError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: DialogAddMemberUi(),
    );
  }
}

class DialogAddMemberUi extends StatefulWidget {
  const DialogAddMemberUi({super.key});

  @override
  State<DialogAddMemberUi> createState() => _DialogAddMemberUiState();
}

class _DialogAddMemberUiState extends State<DialogAddMemberUi> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final noteController = TextEditingController();
  final startDataController = TextEditingController();
  final newDataController = TextEditingController();
  String? selectedGender;
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      padding: 0,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          shrinkWrap: true,
          children: [
            FieldLabelAndInput(
              label: 'الاسم',
              child: TextFieldAddMember(controller: nameController),
            ),

            FieldLabelAndInput(
              label: 'الهاتف',
              child: TextFieldAddMember(controller: phoneController),
            ),
            FieldLabelAndInput(
              label: 'ملحوظات',
              child: TextFieldAddMember(controller: noteController),
            ),
            const SizedBox(height: 10),
            DoubleFieldRow(
              leftLabel: 'تاريخ الانضمام',
              leftChild: TextFieldAddMember(controller: newDataController),
              rightLabel: 'النوع',
              rightChild: CustomDropdownToAddMember(
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
            DoubleFieldRow(
              leftLabel: 'تاريخ البدء',
              leftChild: TextFieldAddMember(controller: startDataController),
              rightLabel: '',
              rightChild: ElevatedButtonWidget(
                text: 'المده',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SelectSupView();
                      },
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 30),
            Row(
              children: [
                ElevatedButtonWidget(
                  text: 'حغظ',
                  onPressed: () {
                    final member = MemberModel(
                      note: '',
                      id: '1',
                      name: nameController.text,
                      phone: phoneController.text,
                      startdata: startDataController.text,
                      enddata: '30',
                      attendance: '',
                      absence: '',
                      status: 'active',
                      gender: selectedGender.toString(),
                    );

                    context.read<MembersCubit>().addMember(member);
                  },
                ),
                const SizedBox(width: 10),
                ElevatedButtonToDialog(
                  text: 'يلغي',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
