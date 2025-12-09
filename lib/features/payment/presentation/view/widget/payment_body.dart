import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/features/payment/presentation/view/widget/dialog_add_payment.dart';
import 'package:power_gym/features/payment/presentation/view/widget/payment_data.dart';
import 'package:power_gym/features/payment/presentation/view/widget/top_section_of_payment.dart';

class PaymentBody extends StatelessWidget {
  const PaymentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('المدفوعات', style: AppStyle.stylebold26),
          TopSectionOfPayment(),
          SizedBox(height: 15),
          Expanded(child: PaymentData()),
          const SizedBox(height: 30),
          ElevatedButtonWidget(
            text: 'اضافة مصاريف',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(child: DialogAddPayment());
                },
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
