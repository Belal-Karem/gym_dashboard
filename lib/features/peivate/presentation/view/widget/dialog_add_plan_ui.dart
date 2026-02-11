import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/custom_dropdown_widget.dart';
import 'package:power_gym/core/widget/double_field_row_add_widget.dart';
import 'package:power_gym/core/widget/elevated_button_to_dialog.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/field_label_and_input_add_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/peivate/data/models/private_model/private_model.dart';
import 'package:power_gym/features/peivate/presentation/manger/cubit/private_cubit.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';
import 'package:power_gym/features/trainers/presentation/manger/cubit/trainer_cubit.dart';

class DialogAddPlanUi extends StatefulWidget {
  const DialogAddPlanUi({super.key, required this.member});

  final MemberModel member;

  @override
  State<DialogAddPlanUi> createState() => _DialogAddPlanUiState();
}

class _DialogAddPlanUiState extends State<DialogAddPlanUi> {
  final durationController = TextEditingController();
  final sessionController = TextEditingController();
  final priceController = TextEditingController();

  TrainerModel? selectedTrainer;
  String? selectedMethod = 'نقدي';

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<TrainerCubit>().loadTrainer();
  }

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
    final now = DateTime.now();

    final days = int.tryParse(durationController.text.trim()) ?? 0;

    final endDate = now.add(Duration(days: days));
    return Stack(
      children: [
        Form(
          key: formKey,
          child: CustomContainerStatistics(
            padding: 0,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    'العضو: ${widget.member.name}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  DoubleFieldRowAddWidget(
                    leftLabel: 'المدة',
                    leftChild: TextFieldAddWidget(
                      controller: durationController,
                    ),
                    rightLabel: 'الجلسات',
                    rightChild: TextFieldAddWidget(
                      controller: sessionController,
                    ),
                  ),

                  const SizedBox(height: 10),

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
                      initialValue: selectedMethod,
                      onChanged: (value) {
                        setState(() => selectedMethod = value);
                      },
                    ),

                    rightLabel: 'المدرب',
                    rightChild: DropdownButtonFormField<TrainerModel>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      value: selectedTrainer,
                      items: trainers.map((trainer) {
                        return DropdownMenuItem<TrainerModel>(
                          value: trainer,
                          child: Text(trainer.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => selectedTrainer = value);
                      },
                      validator: (value) =>
                          value == null ? 'من فضلك اختر المدرب' : null,
                    ),
                  ),
                  FieldLabelAndInputAddWidget(
                    label: 'السعر',
                    child: TextFieldAddWidget(controller: priceController),
                  ),
                  const Divider(height: 30),

                  Row(
                    children: [
                      ElevatedButtonWidget(
                        text: 'حفظ',
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          final paymentCubit = context.read<PaymentCubit>();
                          final private = PrivateModel(
                            id: '',
                            member: widget.member,
                            trainer: selectedTrainer!,
                            totalSessions: int.parse(sessionController.text),
                            method: selectedMethod.toString(),
                            paid: double.parse(priceController.text),
                            duration: durationController.text,
                            status: PrivateStatus.active,
                            private: 'private',
                            usedSessions: 0,
                            endDate: endDate,
                            startDate: now,
                          );
                          context.read<PrivateCubit>().addPrivate(
                            private,
                            paymentCubit,
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      ElevatedButtonToDialog(
                        text: 'إلغاء',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        BlocBuilder<PrivateCubit, PrivateState>(
          builder: (context, state) {
            if (state is AddPrivateLoading) {
              return Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
