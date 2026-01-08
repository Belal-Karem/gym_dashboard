import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/custom_dropdown_widget.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/core/widget/double_field_row_add_widget.dart';
import 'package:power_gym/core/widget/elevated_button_to_dialog.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/field_label_and_input_add_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_cubit.dart';

class DialogAddSubscriptionsUi extends StatefulWidget {
  const DialogAddSubscriptionsUi({super.key});

  @override
  State<DialogAddSubscriptionsUi> createState() =>
      _DialogAddSubscriptionsUiState();
}

class _DialogAddSubscriptionsUiState extends State<DialogAddSubscriptionsUi> {
  final typeController = TextEditingController();
  final durationController = TextEditingController();
  final freezeController = TextEditingController();
  final invitationController = TextEditingController();
  final priceController = TextEditingController();
  final maxAttendanceController = TextEditingController();
  // final priceController = TextEditingController();
  String? selectedType = 'نشط';
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      // autovalidateMode: autovalidateMode,
      child: CustomContainerStatistics(
        padding: 0,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            shrinkWrap: true,
            children: [
              DoubleFieldRowAddWidget(
                leftLabel: 'اسم الشتراك ',
                leftChild: TextFieldAddWidget(controller: typeController),
                rightLabel: 'عدد الايام',
                rightChild: TextFieldAddWidget(controller: durationController),
              ),
              DoubleFieldRowAddWidget(
                leftLabel: 'التوقيف المواقت',
                leftChild: TextFieldAddWidget(controller: freezeController),
                rightLabel: 'دعوه',
                rightChild: TextFieldAddWidget(
                  controller: invitationController,
                ),
              ),
              FieldLabelAndInputAddWidget(
                label: 'السعر',
                child: TextFieldAddWidget(controller: priceController),
              ),
              const SizedBox(height: 10),
              DoubleFieldRowAddWidget(
                leftLabel: 'أقصى حضور',
                leftChild: TextFieldAddWidget(
                  controller: maxAttendanceController,
                ),

                rightLabel: 'حاله',
                rightChild: CustomDropdownWidget(
                  items: [
                    DropdownMenuItem(value: 'نشط', child: Text('نشط')),
                    DropdownMenuItem(value: 'متوقف', child: Text('متوقف')),
                    // DropdownMenuItem(value: 'طفل', child: Text('طفل')),
                  ],
                  initialValue: selectedType,
                  onChanged: (value) {
                    setState(() => selectedType = value);
                  },
                ),
              ),
              const Divider(height: 30),
              Row(
                children: [
                  ElevatedButtonWidget(
                    text: 'حغظ',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final addSub = SubModel(
                          id: '',
                          durationDays: int.parse(durationController.text),
                          freezeDays: int.parse(freezeController.text),
                          invitationCount: int.parse(invitationController.text),
                          type: typeController.text.trim(),
                          status: selectedType.toString(),
                          price: double.parse(priceController.text),
                          maxAttendance: int.parse(
                            maxAttendanceController.text,
                          ),
                        );

                        context.read<SubCubit>().addSub(addSub);
                      } else {
                        CustomErrorWidget(
                          errMessage: 'يرجى تصحيح الأخطاء الموجودة في النموذج',
                        );
                      }
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
      ),
    );
  }
}
