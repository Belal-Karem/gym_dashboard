import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/helper/build_error_bar.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_state.dart';
import 'package:power_gym/features/payment/presentation/view/widget/payment_data_taple.dart';

import '../../../../../core/widget/app_loading_widget.dart';

class PaymentData extends StatelessWidget {
  const PaymentData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state is PaymentLoading) {
          return AppLoadingWidget();
        } else if (state is PaymentLoaded) {
          final payment = state.payments;
          return PaymentDataTaple(payment: payment);
        } else if (state is PaymentError) {
          buildErrorBar(context, state.message);
        } else {
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
