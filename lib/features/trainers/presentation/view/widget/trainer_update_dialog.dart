import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/utils/constants.dart';
import 'package:power_gym/core/widget/custom_dropdown_widget.dart';
import 'package:power_gym/core/widget/field_label_and_input_add_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';
import 'package:power_gym/features/trainers/presentation/manger/cubit/trainer_cubit.dart';

class TrainerUpdateDialog extends StatefulWidget {
  final TrainerModel trainer;

  const TrainerUpdateDialog({super.key, required this.trainer});

  @override
  State<TrainerUpdateDialog> createState() => _TrainerUpdateDialogState();
}

class _TrainerUpdateDialogState extends State<TrainerUpdateDialog> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.trainer.name);
    phoneController = TextEditingController(text: widget.trainer.phone);

    selectedStatus = widget.trainer.status;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  void updateTrainer() {
    final updatedTrainer = widget.trainer.copyWith(
      name: nameController.text,
      phone: phoneController.text,
      status: selectedStatus ?? widget.trainer.status,
    );

    BlocProvider.of<TrainerCubit>(
      context,
    ).updateTrainer(updatedTrainer.id, updatedTrainer.toJson());
    Navigator.pop(context);
  }

  void deleteTrainer() {
    BlocProvider.of<TrainerCubit>(context).deleteTrainer(widget.trainer.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kprimaryColor,
      title: const Text('تعديل بيانات العضو'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FieldLabelAndInputAddWidget(
              label: 'الاسم',
              child: TextFieldAddWidget(controller: nameController),
            ),
            FieldLabelAndInputAddWidget(
              label: 'الهاتف',
              child: TextFieldAddWidget(controller: phoneController),
            ),

            FieldLabelAndInputAddWidget(
              label: 'الحالة',
              child: CustomDropdownWidget(
                items: const [
                  DropdownMenuItem(value: 'نشط', child: Text('نشط')),
                  DropdownMenuItem(value: 'متوقف', child: Text('متوقف')),
                  DropdownMenuItem(value: 'انتظار', child: Text('انتظار')),
                ],
                initialValue: selectedStatus,
                onChanged: (value) {
                  setState(() => selectedStatus = value);
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: deleteTrainer,
          child: const Text('حذف', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: updateTrainer,
          child: const Text('تحديث', style: TextStyle(color: Colors.blue)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إغلاق'),
        ),
      ],
    );
  }
}
