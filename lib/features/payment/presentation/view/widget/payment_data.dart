import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_state.dart';
import 'package:power_gym/features/payment/presentation/view/widget/payment_data_taple.dart';

class PaymentData extends StatelessWidget {
  const PaymentData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state is PaymentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PaymentLoaded) {
          final payment = state.payment;
          return PaymentDataTaple(payment: payment);
        } else if (state is PaymentError) {
          return CustomErrorWidget(errMessage: state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
