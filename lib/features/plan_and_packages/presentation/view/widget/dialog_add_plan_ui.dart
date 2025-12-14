import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/double_field_row_add_widget.dart';
import 'package:power_gym/core/widget/elevated_button_to_dialog.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/plan_and_packages/data/models/plan_model/plan_model.dart';
import 'package:power_gym/features/plan_and_packages/presentation/manger/cubit/plan_cubit.dart';
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

    return Stack(
      children: [
        /// ================= UI =================
        Form(
          key: formKey,
          child: CustomContainerStatistics(
            padding: 0,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                shrinkWrap: true,
                children: [
                  /// ----------- اسم العضو (ثابت) -----------
                  Text(
                    'العضو: ${widget.member.name}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// ----------- المدة / الجلسات -----------
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

                  /// ----------- السعر / المدرب -----------
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

                  const Divider(height: 30),

                  /// ----------- الأزرار -----------
                  Row(
                    children: [
                      ElevatedButtonWidget(
                        text: 'حفظ',
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;

                          final plan = PlanModel(
                            id: '',
                            member: widget.member, // ✅ صح
                            trainer: selectedTrainer!, // ✅ صح
                            session: sessionController.text,
                            status: 'active',
                            price: priceController.text,
                            attendance: '',
                          );

                          context.read<PlanCubit>().addPlan(plan);
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

        /// ================= Loading Overlay =================
        BlocBuilder<PlanCubit, PlanState>(
          builder: (context, state) {
            if (state is AddPlanLoading) {
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
