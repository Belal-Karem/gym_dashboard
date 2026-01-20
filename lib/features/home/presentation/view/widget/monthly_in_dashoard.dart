import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/home/presentation/view/widget/signal_like_chart.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_state.dart';

class MonthlyInDashoard extends StatelessWidget {
  const MonthlyInDashoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state is PaymentLoading) {
          return const CircularProgressIndicator();
        } else if (state is PaymentLoaded) {
          return MonthlyInDashoardUi(totalToday: state.totalIncomeToday);
        } else if (state is PaymentError) {
          return Text(state.message);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class MonthlyInDashoardUi extends StatelessWidget {
  const MonthlyInDashoardUi({super.key, required this.totalToday});

  final double totalToday;

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                totalToday.toStringAsFixed(0),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Text('الإيرادات اليوميا', style: TextStyle(fontSize: 15)),
            ],
          ),
          SignalLikeChart(totaltoday: totalToday),
        ],
      ),
    );
  }
}
