import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/custom_dropdown_widget.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/core/widget/double_field_row_add_widget.dart';
import 'package:power_gym/core/widget/elevated_button_to_dialog.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/payment/data/models/model/payment_model.dart';

class DialogAddPaymentUi extends StatefulWidget {
  const DialogAddPaymentUi({super.key});

  @override
  State<DialogAddPaymentUi> createState() => _DialogAddPaymentUiState();
}

class _DialogAddPaymentUiState extends State<DialogAddPaymentUi> {
  final typeController = TextEditingController();
  final paidController = TextEditingController();
  final paymentDataController = TextEditingController();
  final maxAttendanceController = TextEditingController();
  String? paymentMethod;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                leftLabel: 'نوع المدفوع',
                leftChild: TextFieldAddWidget(controller: typeController),
                rightLabel: 'السعر',
                rightChild: TextFieldAddWidget(controller: paidController),
              ),
              DoubleFieldRowAddWidget(
                leftLabel: 'وقت الدفع',
                leftChild: TextFieldAddWidget(
                  controller: paymentDataController,
                ),
                rightLabel: 'طريقة الدفع',
                rightChild: CustomDropdownWidget(
                  items: [
                    DropdownMenuItem(value: 'نقدي', child: Text('نقدي')),
                    DropdownMenuItem(value: 'محفظه', child: Text('محفظه')),
                    DropdownMenuItem(
                      value: 'إنستاباي',
                      child: Text('إنستاباي'),
                    ),
                  ],
                  initialValue: paymentMethod,
                  onChanged: (value) {
                    setState(() => paymentMethod = value);
                  },
                ),
              ),
              const SizedBox(height: 10),

              const Divider(height: 30),
              Row(
                children: [
                  ElevatedButtonWidget(
                    text: 'حغظ',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final addPayment = PaymentModel(
                          id: '',
                          type: typeController.text,
                          paid: double.tryParse(paidController.text) ?? 0,
                          paymentMethod: paymentMethod ?? 'نقدي',
                          plan: '_',
                          memberId: '',
                          date: DateTime.now(),
                        );

                        context.read<PaymentCubit>().addPayment(addPayment);
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
