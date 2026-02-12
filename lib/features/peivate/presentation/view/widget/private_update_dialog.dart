import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/peivate/data/models/private_model/private_model.dart';
import 'package:power_gym/features/peivate/presentation/manger/cubit/private_cubit.dart';

class PrivateUpdateDialog extends StatefulWidget {
  final PrivateModel privateModel;

  const PrivateUpdateDialog({super.key, required this.privateModel});

  @override
  State<PrivateUpdateDialog> createState() => _PrivateUpdateDialogState();
}

class _PrivateUpdateDialogState extends State<PrivateUpdateDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void updateSubscriptions() {
  //   final updatedSubscriptions = widget.subModel.copyWith(
  //     type: typeController.text,
  //     durationDays: int.parse(durationController.text),
  //     price: double.parse(priceController.text),
  //     freezeDays: int.parse(freezeController.text),
  //     invitationCount: int.parse(invitationController.text),
  //     maxAttendance: int.parse(maxAttendanceController.text),
  //     status: selectedStatus ?? widget.subModel.status,
  //   );

  //   BlocProvider.of<SubCubit>(
  //     context,
  //   ).updateSub(updatedSubscriptions.id, updatedSubscriptions.toJson());
  //   Navigator.pop(context);
  // }

  void deleteSubscriptions() {
    BlocProvider.of<PrivateCubit>(
      context,
    ).deletePrivate(widget.privateModel.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kprimaryColor,
      // title: const Text('تعديل بيانات العضو'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width / 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // DoubleFieldRowAddWidget(
              //   leftLabel: 'اسم الشتراك ',
              //   leftChild: TextFieldAddWidget(controller: typeController),
              //   rightLabel: 'عدد الايام',
              //   rightChild: TextFieldAddWidget(controller: durationController),
              // ),
              // DoubleFieldRowAddWidget(
              //   leftLabel: 'التوقيف المواقت',
              //   leftChild: TextFieldAddWidget(controller: freezeController),
              //   rightLabel: 'دعوه',
              //   rightChild: TextFieldAddWidget(
              //     controller: invitationController,
              //   ),
              // ),

              // const SizedBox(height: 10),
              // DoubleFieldRowAddWidget(
              //   leftLabel: 'أقصى حضور',
              //   leftChild: TextFieldAddWidget(
              //     controller: maxAttendanceController,
              //   ),

              //   rightLabel: 'حاله',
              //   rightChild: CustomDropdownWidget(
              //     items: [
              //       DropdownMenuItem(value: 'نشط', child: Text('نشط')),
              //       DropdownMenuItem(value: 'متوقف', child: Text('متوقف')),
              //       // DropdownMenuItem(value: 'طفل', child: Text('طفل')),
              //     ],
              //     initialValue: selectedStatus,
              //     onChanged: (value) {
              //       setState(() => selectedStatus = value);
              //     },
              //   ),
              // ),
              // FieldLabelAndInputAddWidget(
              //   label: 'السعر',
              //   child: TextFieldAddWidget(controller: priceController),
              // ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: deleteSubscriptions,
          child: const Text('حذف', style: TextStyle(color: Colors.red)),
        ),
        // TextButton(
        //   onPressed: updateSubscriptions,
        //   child: const Text('تحديث', style: TextStyle(color: Colors.blue)),
        // ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إغلاق'),
        ),
      ],
    );
  }
}
