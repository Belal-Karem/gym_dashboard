import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/utils/constants.dart';
import 'package:power_gym/core/widget/custom_dropdown_widget.dart';
import 'package:power_gym/core/widget/double_field_row_add_widget.dart';
import 'package:power_gym/core/widget/field_label_and_input_add_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_cubit.dart';

class SubscriptionsUpdateDialog extends StatefulWidget {
  final SubModel subModel;

  const SubscriptionsUpdateDialog({super.key, required this.subModel});

  @override
  State<SubscriptionsUpdateDialog> createState() =>
      _SubscriptionsUpdateDialogState();
}

class _SubscriptionsUpdateDialogState extends State<SubscriptionsUpdateDialog> {
  late TextEditingController typeController;
  late TextEditingController durationController;
  late TextEditingController priceController;
  late TextEditingController freezeController;
  late TextEditingController invitationController;
  late TextEditingController maxAttendanceController;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    typeController = TextEditingController(text: widget.subModel.type);
    durationController = TextEditingController(
      text: widget.subModel.duration.toString(),
    );
    priceController = TextEditingController(text: widget.subModel.price);
    freezeController = TextEditingController(
      text: widget.subModel.freeze.toString(),
    );
    invitationController = TextEditingController(
      text: widget.subModel.invitation.toString(),
    );
    maxAttendanceController = TextEditingController(
      text: widget.subModel.maxAttendance,
    );
    selectedStatus = widget.subModel.status;
  }

  @override
  void dispose() {
    typeController.dispose();
    durationController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void updateSubscriptions() {
    final updatedSubscriptions = widget.subModel.copyWith(
      type: typeController.text,
      duration: durationController.text,
      status: selectedStatus ?? widget.subModel.status,
    );

    BlocProvider.of<SubCubit>(
      context,
    ).updateSub(updatedSubscriptions.id, updatedSubscriptions.toJson());
    Navigator.pop(context);
  }

  void deleteSubscriptions() {
    BlocProvider.of<SubCubit>(context).deleteSub(widget.subModel.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kprimaryColor,
      title: const Text('تعديل بيانات العضو'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width / 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  initialValue: selectedStatus,
                  onChanged: (value) {
                    setState(() => selectedStatus = value);
                  },
                ),
              ),
              FieldLabelAndInputAddWidget(
                label: 'السعر',
                child: TextFieldAddWidget(controller: priceController),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: deleteSubscriptions,
          child: const Text('حذف', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: updateSubscriptions,
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
