import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/members_statistics_card.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_state.dart';

class PaymentStatisticsRow extends StatelessWidget {
  const PaymentStatisticsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state is PaymentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PaymentLoaded) {
          return PaymentStatisticsRowData(
            todayIncome: state.totalIncomeToday,
            todayOutcome: state.totalOutcomeToday,
          );
        } else if (state is PaymentError) {
          return Text(state.message);
        }
        return const SizedBox();
      },
    );
  }
}

class PaymentStatisticsRowData extends StatelessWidget {
  final double todayIncome;
  final double todayOutcome;

  const PaymentStatisticsRowData({
    super.key,
    required this.todayIncome,
    required this.todayOutcome,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: MembersStatisticsCard(
              number: todayIncome.toInt(),
              text: 'الدخل',
            ),
          ),
          Expanded(
            child: MembersStatisticsCard(
              number: todayOutcome.toInt(),
              text: 'الخارج',
              textStyle: TextStyle(fontSize: 15, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
