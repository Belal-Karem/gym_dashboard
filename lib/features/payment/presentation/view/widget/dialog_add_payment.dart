import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_state.dart';
import 'package:power_gym/features/payment/presentation/view/widget/dialog_add_payment_ui.dart';

class DialogAddPayment extends StatelessWidget {
  const DialogAddPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is AddPaymentLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AddPaymentSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
          CustomErrorWidget(errMessage: 'تم إضافة الدفع !');
          context.read<PaymentCubit>().loadPayment();
        } else if (state is AddPaymentError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: DialogAddPaymentUi(),
    );
  }
}
