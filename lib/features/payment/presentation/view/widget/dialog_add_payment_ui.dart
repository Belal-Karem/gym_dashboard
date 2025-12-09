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
import 'package:power_gym/features/payment/data/models/model/cubit/payment_cubit.dart';
import 'package:power_gym/features/payment/data/models/model/payment_model.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_cubit.dart';

class DialogAddSubscriptionsUi extends StatefulWidget {
  const DialogAddSubscriptionsUi({super.key});

  @override
  State<DialogAddSubscriptionsUi> createState() =>
      _DialogAddSubscriptionsUiState();
}

class _DialogAddSubscriptionsUiState extends State<DialogAddSubscriptionsUi> {
  final typeController = TextEditingController();
  final paidController = TextEditingController();
  final paymentDataController = TextEditingController();
  final priceController = TextEditingController();
  final maxAttendanceController = TextEditingController();
  // final priceController = TextEditingController();
  String? paymentMethod = 'نقدي';
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
                rightLabel: 'عدد الايام',
                rightChild: TextFieldAddWidget(controller: priceController),
              ),
              DoubleFieldRowAddWidget(
                leftLabel: 'وقت الدفع',
                leftChild: TextFieldAddWidget(
                  controller: paymentDataController,
                ),
                rightLabel: 'دعوه',
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
                          paid: '',
                          paymentData: paymentDataController.text,
                          paymentMethod: paymentMethod.toString(),
                          plan: 'month',
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
