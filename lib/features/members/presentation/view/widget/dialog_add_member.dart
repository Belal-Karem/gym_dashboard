import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/elevated_button_to_dialog.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/features/members/presentation/view/select_sup_view.dart';
import 'package:power_gym/features/members/presentation/view/widget/custom_dropdown_to_add_member.dart';
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
            const _FieldLabelAndInput(
              label: 'الاسم',
              child: TextFieldAddMember(),
            ),

            const _FieldLabelAndInput(
              label: 'الهاتف',
              child: TextFieldAddMember(),
            ),
            const _FieldLabelAndInput(
              label: 'ملحوظات',
              child: TextFieldAddMember(),
            ),
            const SizedBox(height: 10),
            const _DoubleFieldRow(
              leftLabel: 'تاريخ الانضمام',
              leftChild: TextFieldAddMember(),
              rightLabel: 'النوع',
              rightChild: CustomDropdownToAddMember(
                items: [
                  DropdownMenuItem(value: '1', child: Text('ذكر')),
                  DropdownMenuItem(value: '2', child: Text('أنثى')),
                ],
              ),
            ),
            const _DoubleFieldRow(
              leftLabel: 'تاريخ البدء',
              leftChild: TextFieldAddMember(),
              rightLabel: 'المده',
              rightChild: CustomDropdownToAddMember(
                items: [
                  DropdownMenuItem(value: '1', child: Text('month')),
                  DropdownMenuItem(value: '2', child: Text('3 monthe')),
                ],
              ),
            ),
            Divider(height: 30),
            Row(
              children: [
                ElevatedButtonWidget(
                  text: 'حغظ',
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

class _FieldLabelAndInput extends StatelessWidget {
  final String label;
  final Widget child;

  const _FieldLabelAndInput({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyle.style20W500),
        const SizedBox(height: 5),
        child,
        const SizedBox(height: 15),
      ],
    );
  }
}

class _DoubleFieldRow extends StatelessWidget {
  final String leftLabel, rightLabel;
  final Widget leftChild, rightChild;

  const _DoubleFieldRow({
    required this.leftLabel,
    required this.leftChild,
    required this.rightLabel,
    required this.rightChild,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _FieldLabelAndInput(label: leftLabel, child: leftChild),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _FieldLabelAndInput(label: rightLabel, child: rightChild),
        ),
      ],
    );
  }
}
