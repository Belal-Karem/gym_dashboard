import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/report/data/models/repo/subscription_report_repo.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/subscription_report_cubit.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/subscription_report_state.dart';
import 'package:power_gym/features/report/presentation/view/widget/Subscriptions.dart';

class SubscriptionData extends StatelessWidget {
  const SubscriptionData({super.key, required this.date});
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionReportCubit, SubscriptionReportState>(
      builder: (context, state) {
        if (state is SubscriptionReportLoading) {
          return const CircularProgressIndicator();
        }

        if (state is SubscriptionReportLoaded) {
          return Subscriptions(
            newSubsCount: state.newSubscriptions.length,
            renewalsCount: state.renewals.length,
            date: date,
            repo: context.read<SubscriptionReportRepo>(),
          );
        }

        if (state is SubscriptionReportError) {
          return Text(state.message);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
