import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/gradient_scaffold.dart';
import 'package:power_gym/core/widget/logo_and_name.dart';
import 'package:power_gym/features/payment/presentation/view/widget/payment_statistics_row_data.dart';
import 'package:power_gym/features/payment/presentation/view/widget/payment_view_body.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          Row(
            children: [
              LogoAndName(),
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
