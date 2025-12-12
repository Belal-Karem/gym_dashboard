import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/core/widget/double_field_row_add_widget.dart';
import 'package:power_gym/core/widget/elevated_button_to_dialog.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';
import 'package:power_gym/features/trainers/presentation/manger/cubit/trainer_cubit.dart';

class DialogAddPlanUi extends StatefulWidget {
  const DialogAddPlanUi({super.key});

  @override
  State<DialogAddPlanUi> createState() => _DialogAddPlanUiState();
}

class _DialogAddPlanUiState extends State<DialogAddPlanUi> {
  final durationController = TextEditingController();
  final sessionController = TextEditingController();
  final priceController = TextEditingController();
  TrainerModel? selectedTrainer;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    durationController.dispose();
    sessionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trainers = context.watch<TrainerCubit>().trainersList;

    return Form(
      key: formKey,
      child: CustomContainerStatistics(
        padding: 0,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            shrinkWrap: true,
            children: [
              DoubleFieldRowAddWidget(
                leftLabel: 'المده',
                leftChild: TextFieldAddWidget(controller: durationController),
                rightLabel: 'الجلسات',
                rightChild: TextFieldAddWidget(controller: sessionController),
              ),

              DoubleFieldRowAddWidget(
                leftLabel: 'السعر',
                leftChild: TextFieldAddWidget(controller: priceController),

                rightLabel: 'المدرب',
                rightChild: DropdownButtonFormField<TrainerModel>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  value: selectedTrainer,
                  items: trainers.map((trainer) {
                    return DropdownMenuItem(
                      value: trainer,
                      child: Text(trainer.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => selectedTrainer = value);
                  },
                  validator: (value) => value == null ? 'اختر المدرب' : null,
                ),
              ),

              const SizedBox(height: 10),
              const Divider(height: 30),

              Row(
                children: [
                  ElevatedButtonWidget(
                    text: 'حفظ',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // final plan = PlanModel(
                        //   duration: durationController.text,
                        //   sessions: sessionController.text,
                        //   price: priceController.text,
                        //   maxAttendance: maxAttendanceController.text,
                        //   trainer: selectedTrainer!, // ← مهم
                        // );

                        // context.read<PlanCubit>().addPlan(plan);
                        Navigator.pop(context);
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
