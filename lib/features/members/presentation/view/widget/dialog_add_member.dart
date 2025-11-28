import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/elevated_button_to_dialog.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/features/members/presentation/view/select_sup_view.dart';
import 'package:power_gym/features/members/presentation/view/widget/custom_dropdown_to_add_member.dart';
import 'package:power_gym/features/members/presentation/view/widget/double_field_row.dart';
import 'package:power_gym/features/members/presentation/view/widget/field_label_and_input.dart';
import 'package:power_gym/features/members/presentation/view/widget/text_field_add_member.dart';

class DialogAddMember extends StatelessWidget {
  const DialogAddMember({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      padding: 0,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          shrinkWrap: true,
          children: [
            const FieldLabelAndInput(
              label: 'الاسم',
              child: TextFieldAddMember(),
            ),

            const FieldLabelAndInput(
              label: 'الهاتف',
              child: TextFieldAddMember(),
            ),
            const FieldLabelAndInput(
              label: 'ملحوظات',
              child: TextFieldAddMember(),
            ),
            const SizedBox(height: 10),
            const DoubleFieldRow(
              leftLabel: 'تاريخ الانضمام',
              leftChild: TextFieldAddMember(),
              rightLabel: 'النوع',
              rightChild: CustomDropdownToAddMember(
                items: [
                  DropdownMenuItem(value: '1', child: Text('ذكر')),
                  DropdownMenuItem(value: '2', child: Text('أنثى')),
                  DropdownMenuItem(value: '2', child: Text('طفل')),
                ],
              ),
            ),
            DoubleFieldRow(
              leftLabel: 'تاريخ البدء',
              leftChild: TextFieldAddMember(),
              rightLabel: '',
              rightChild: ElevatedButtonWidget(
                text: 'المده',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SelectSupView();
                      },
                    ),
                  );
                },
              ),
            ),
            Divider(height: 30),
            Row(
              children: [
                ElevatedButtonWidget(
                  text: 'حغظ',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 10),
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
