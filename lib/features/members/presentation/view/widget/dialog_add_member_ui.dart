import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/view/select_sup_view.dart';
import 'package:power_gym/features/members/presentation/view/widget/custom_dropdown_to_add_member.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/double_field_row_add_widget.dart';
import 'package:power_gym/core/widget/elevated_button_to_dialog.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/field_label_and_input_add_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

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
            FieldLabelAndInputAddWidget(
              label: 'الاسم',
              child: TextFieldAddWidget(controller: nameController),
            ),

            FieldLabelAndInputAddWidget(
              label: 'الهاتف',
              child: TextFieldAddWidget(controller: phoneController),
            ),
            FieldLabelAndInputAddWidget(
              label: 'ملحوظات',
              child: TextFieldAddWidget(controller: noteController),
            ),
            const SizedBox(height: 10),
            DoubleFieldRowAddWidget(
              leftLabel: 'تاريخ الانضمام',
              leftChild: TextFieldAddWidget(controller: newDataController),
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
            DoubleFieldRowAddWidget(
              leftLabel: 'تاريخ البدء',
              leftChild: TextFieldAddWidget(controller: startDataController),
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
