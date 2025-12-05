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
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';
import 'package:power_gym/features/trainers/presentation/manger/cubit/trainer_cubit.dart';

class DialogAddTrainerUi extends StatefulWidget {
  const DialogAddTrainerUi({super.key});

  @override
  State<DialogAddTrainerUi> createState() => _DialogAddTrainerUiState();
}

class _DialogAddTrainerUiState extends State<DialogAddTrainerUi> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String? selectedstatus = 'نشط';
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: CustomContainerStatistics(
        padding: 0,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            shrinkWrap: true,
            children: [
              DoubleFieldRowAddWidget(
                leftLabel: 'الاسم',
                leftChild: TextFieldAddWidget(controller: nameController),
                rightLabel: 'الحاله',
                rightChild: CustomDropdownWidget(
                  items: [
                    DropdownMenuItem(value: 'نشط', child: Text('نشط')),
                    DropdownMenuItem(value: 'متوقف', child: Text('متوقف')),
                    DropdownMenuItem(value: 'انتظار', child: Text('انتظار')),
                  ],
                  initialValue: selectedstatus,
                  onChanged: (value) {
                    setState(() => selectedstatus = value);
                  },
                ),
              ),
              FieldLabelAndInputAddWidget(
                label: 'الهاتف',
                child: TextFieldAddWidget(
                  controller: phoneController,
                  validator: (value) {
                    if (value!.trim().length != 11) {
                      return 'رقم الموبايل يجب أن يكون 11 رقمًا';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
                      return 'رقم الموبايل يجب أن يحتوي أرقام فقط';
                    }
                    // return 'الرجاء ملء البيانات ';
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
                        final addTainer = TrainerModel(
                          id: '',
                          name: nameController.text,
                          phone: phoneController.text,
                          ptNumber: '1',
                          status: selectedstatus.toString(),
                        );
                        context.read<TrainerCubit>().addTrainer(addTainer);
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
