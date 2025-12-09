import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/features/members/presentation/view/widget/dialog_add_member_ui.dart';
import 'package:power_gym/features/payment/data/models/model/cubit/payment_cubit.dart';
import 'package:power_gym/features/payment/data/models/model/cubit/payment_state.dart';

class DialogAddSubscriptions extends StatelessWidget {
  const DialogAddSubscriptions({super.key});

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
          CustomErrorWidget(errMessage: 'تم إضافة العضو الشتراك!');
          context.read<PaymentCubit>().loadPayment();
        } else if (state is AddPaymentError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: DialogAddMemberUi(),
    );
  }
}
