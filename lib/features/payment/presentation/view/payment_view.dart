import 'package:flutter/material.dart';
import 'package:power_gym/features/payment/presentation/view/widget/payment_statistics_row_data.dart';
import 'package:power_gym/features/payment/presentation/view/widget/payment_view_body.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/image/image.png', height: 120, width: 120),
              Text('Power House Gym', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 100),
              const PaymentStatisticsRow(),
            ],
          ),
          PaymentViewBody(),
        ],
      ),
    );
  }
}
