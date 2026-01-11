import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  void initState() {
    super.initState();
    // ✅ Set default start date to today
    controller.startDate.text = DateFormat(
      'yyyy-MM-dd',
      'en_US',
    ).format(DateTime.now());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // ✅ ADDED: Date Picker Function
  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xff9D1D1E),
              onPrimary: Colors.white,
              surface: Color(0xff1D1E22),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
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

              FieldLabelAndInputAddWidget(
                label: 'ملحوظات',
                child: TextFieldAddWidget(
                  controller: controller.note,
                  validator: (v) => null, // ✅ Fixed: Allow empty notes
                ),
              ),

              const SizedBox(height: 10),

              DoubleFieldRowAddWidget(
                leftLabel: 'تاريخ البدء',
                leftChild: GestureDetector(
                  onTap: () => _selectDate(context, controller.startDate),
                  child: AbsorbPointer(
                    child: TextFieldAddWidget(
                      controller: controller.startDate,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء اختيار تاريخ البدء';
                        }
                        return null;
                      },
                    ),
                  ),
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
                leftLabel: 'طريقة الدفع',
                leftChild: CustomDropdownWidget(
                  items: [
                    DropdownMenuItem(value: 'نقدي', child: Text('نقدي')),
                    DropdownMenuItem(value: 'محفظه', child: Text('محفظه')),
                    DropdownMenuItem(value: 'فيزا', child: Text('فيزا')),
                    DropdownMenuItem(
                      value: 'إنستاباي',
                      child: Text('إنستاباي'),
                    ),
                  ],
                  initialValue: controller.paymentMethod,
                  onChanged: controller.setpaymentMethod,
                ),
                rightLabel: 'الحالة',
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
