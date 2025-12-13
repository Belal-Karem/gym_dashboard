import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/double_field_row_add_widget.dart';
import 'package:power_gym/core/widget/elevated_button_to_dialog.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_state.dart';
import 'package:power_gym/features/plan_and_packages/data/models/plan_model/plan_model.dart';
import 'package:power_gym/features/plan_and_packages/presentation/manger/cubit/plan_cubit.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';
import 'package:power_gym/features/trainers/presentation/manger/cubit/trainer_cubit.dart';

// class DialogAddPlanUi extends State<DialogAddPlanUi> {
//   final durationController = TextEditingController();
//   final sessionController = TextEditingController();
//   final priceController = TextEditingController();

//   TrainerModel? selectedTrainer;
//   MemberModel? selectedMember;

//   final formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     context.read<MembersCubit>().loadMembers(); // تحميل الأعضاء
//   }

//   @override
//   void dispose() {
//     durationController.dispose();
//     sessionController.dispose();
//     priceController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final trainers = context.watch<TrainerCubit>().trainersList;

//     return Form(
//       key: formKey,
//       child: CustomContainerStatistics(
//         padding: 0,
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: ListView(
//             shrinkWrap: true,
//             children: [
//               // اختيار العضو
//               BlocBuilder<MembersCubit, MembersState>(
//                 builder: (context, state) {
//                   if (state is MembersLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (state is MembersLoaded) {
//                     return DropdownButtonFormField<MemberModel>(
//                       decoration: const InputDecoration(
//                         labelText: 'اختر العضو',
//                         border: OutlineInputBorder(),
//                       ),
//                       value: selectedMember,
//                       items: state.members.map((member) {
//                         return DropdownMenuItem(
//                           value: member,
//                           child: Text(member.name),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() => selectedMember = value);
//                       },
//                       validator: (value) => value == null ? 'اختر العضو' : null,
//                     );
//                   } else if (state is MembersError) {
//                     return Text('حدث خطأ: ${state.message}');
//                   } else {
//                     return const SizedBox();
//                   }
//                 },
//               ),

//               const SizedBox(height: 15),

//               // باقي الحقول والمدرب
//               DoubleFieldRowAddWidget(
//                 leftLabel: 'المده',
//                 leftChild: TextFieldAddWidget(controller: durationController),
//                 rightLabel: 'الجلسات',
//                 rightChild: TextFieldAddWidget(controller: sessionController),
//               ),

//               DoubleFieldRowAddWidget(
//                 leftLabel: 'السعر',
//                 leftChild: TextFieldAddWidget(controller: priceController),
//                 rightLabel: 'المدرب',
//                 rightChild: DropdownButtonFormField<TrainerModel>(
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                   ),
//                   value: selectedTrainer,
//                   items: trainers.map((trainer) {
//                     return DropdownMenuItem(
//                       value: trainer,
//                       child: Text(trainer.name),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() => selectedTrainer = value);
//                   },
//                   validator: (value) => value == null ? 'اختر المدرب' : null,
//                 ),
//               ),

//               const SizedBox(height: 10),
//               const Divider(height: 30),

//               Row(
//                 children: [
//                   ElevatedButtonWidget(
//                     text: 'حفظ',
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         final plan = PlanModel(
//                           id: '',
//                           memberid: selectedMember!.id,
//                           trainerid: selectedTrainer!,
//                           session: sessionController.text,
//                           status: 'active',
//                           price: priceController.text,
//                           attendance: '',
//                         );

//                         context.read<PlanCubit>().addPlan(plan);
//                       }
//                     },
//                   ),
//                   const SizedBox(width: 10),
//                   ElevatedButtonToDialog(
//                     text: 'يلغي',
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
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
  MemberModel? selectedMember;
  final formKey = GlobalKey<FormState>();

  List<MemberModel> allMembers = [];
  List<MemberModel> filteredMembers = [];
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MembersCubit>().loadMembers();
  }

  @override
  void dispose() {
    durationController.dispose();
    sessionController.dispose();
    priceController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void filterMembers(String query) {
    setState(() {
      filteredMembers = allMembers
          .where((m) => m.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
              // البحث واختيار العضو
              BlocBuilder<MembersCubit, MembersState>(
                builder: (context, state) {
                  if (state is MembersLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MembersLoaded) {
                    allMembers = state.members;
                    filteredMembers = filteredMembers.isEmpty
                        ? allMembers
                        : filteredMembers;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            labelText: 'ابحث عن العضو',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: filterMembers,
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 150, // ارتفاع القائمة
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ListView.builder(
                            itemCount: filteredMembers.length,
                            itemBuilder: (context, index) {
                              final member = filteredMembers[index];
                              return ListTile(
                                title: Text(
                                  '${member.name} (ID: ${member.id})',
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedMember = member;
                                    searchController.text = member.name;
                                    filteredMembers = [];
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is MembersError) {
                    return Text('حدث خطأ: ${state.message}');
                  } else {
                    return const SizedBox();
                  }
                },
              ),

              const SizedBox(height: 15),

              // باقي الحقول والمدرب
              DoubleFieldRowAddWidget(
                leftLabel: 'المده',
                leftChild: TextFieldAddWidget(controller: durationController),
                rightLabel: 'الجلسات',
                rightChild: TextFieldAddWidget(controller: sessionController),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField<TrainerModel>(
                decoration: const InputDecoration(
                  labelText: 'اختر المدرب',
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

              const SizedBox(height: 10),
              const Divider(height: 30),

              Row(
                children: [
                  ElevatedButtonWidget(
                    text: 'حفظ',
                    onPressed: () {
                      if (formKey.currentState!.validate() &&
                          selectedMember != null) {
                        final plan = PlanModel(
                          memberid: selectedMember!.id,
                          trainerid: selectedTrainer!,
                          session: sessionController.text,
                          status: '',
                          price: priceController.text,
                          attendance: '',
                          id: '',
                        );

                        context.read<PlanCubit>().addPlan(plan);
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
