import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/home/presentation/view/widget/signal_like_chart.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_state.dart';

class MonthlyInDashoard extends StatefulWidget {
  const MonthlyInDashoard({super.key});

  @override
  State<MonthlyInDashoard> createState() => _MonthlyInDashoardState();
}

class _MonthlyInDashoardState extends State<MonthlyInDashoard> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().loadPayment();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        bool isLoading = false;
        if (state is PaymentLoaded) {
          return MonthlyInDashoardUi(
            totalToday: state.totalIncomeToday,
            isLoading: isLoading,
          );
        }

        if (state is PaymentLoading) {
          // return const CircularProgressIndicator();
          isLoading = true;
        }

        return const SizedBox();
      },
    );
  }
}

class MonthlyInDashoardUi extends StatelessWidget {
  const MonthlyInDashoardUi({
    super.key,
    required this.totalToday,
    required this.isLoading,
  });

  final double totalToday;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      totalToday.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
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
