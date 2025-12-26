import 'package:flutter/material.dart';
import 'package:power_gym/core/validators/validators.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/custom_dropdown_widget.dart';
import 'package:power_gym/core/widget/double_field_row_add_widget.dart';
import 'package:power_gym/core/widget/elevated_button_to_dialog.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/field_label_and_input_add_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/members/presentation/manger/controllers/add_member_controller.dart';

class DialogAddMemberUi extends StatefulWidget {
  const DialogAddMemberUi({super.key});

  @override
  State<DialogAddMemberUi> createState() => _DialogAddMemberUiState();
}

class _DialogAddMemberUiState extends State<DialogAddMemberUi> {
  final controller = AddMemberController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: CustomContainerStatistics(
        padding: 0,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            shrinkWrap: true,
            children: [
              FieldLabelAndInputAddWidget(
                label: 'الاسم',
                child: TextFieldAddWidget(controller: controller.name),
              ),

              FieldLabelAndInputAddWidget(
                label: 'الهاتف',
                child: TextFieldAddWidget(
                  controller: controller.phone,
                  validator: phoneValidator,
                ),
              ),

              const SizedBox(height: 10),

              DoubleFieldRowAddWidget(
                leftLabel: 'ملحوظات ',
                leftChild: TextFieldAddWidget(
                  controller: controller.note,
                  validator: (v) {},
                ),
                rightLabel: 'النوع',
                rightChild: CustomDropdownWidget(
                  items: [
                    DropdownMenuItem(value: 'ذكر', child: Text('ذكر')),
                    DropdownMenuItem(value: 'أنثى', child: Text('أنثى')),
                    DropdownMenuItem(value: 'طفل', child: Text('طفل')),
                  ],
                  initialValue: controller.gender,
                  onChanged: controller.setGender,
                ),
              ),

              DoubleFieldRowAddWidget(
                leftLabel: 'تاريخ البدء',
                leftChild: TextFieldAddWidget(controller: controller.startDate),
                rightLabel: '',
                rightChild: CustomDropdownWidget(
                  items: [
                    DropdownMenuItem(value: 'نشط', child: Text('نشط')),
                    DropdownMenuItem(value: 'متوقف', child: Text('متوقف')),
                    DropdownMenuItem(
                      value: 'توقف مؤقت',
                      child: Text('توقف مؤقت'),
                    ),
                  ],
                  initialValue: controller.status,
                  onChanged: controller.setStatus,
                ),
              ),

              const Divider(height: 30),

              Row(
                children: [
                  ElevatedButtonWidget(
                    text: 'حفظ',
                    onPressed: () => controller.onSave(context),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButtonToDialog(
                    text: 'يلغي',
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
