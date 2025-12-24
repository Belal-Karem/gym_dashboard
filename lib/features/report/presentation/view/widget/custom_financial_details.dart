import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/report/data/models/model/daily_summary_model.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_summary_cubit.dart';

class CustomFinancialDetails extends StatelessWidget {
  const CustomFinancialDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailySummaryCubit, DailySummaryState>(
      builder: (context, state) {
        if (state is DailySummaryLoading) {
          return const CircularProgressIndicator();
        }
        if (state is DailySummaryLoaded) {
          final s = state.summary;
          return CustomFinancialDetailsUi(s: s);
        }
        if (state is DailySummaryError) {
          return Text(state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class CustomFinancialDetailsUi extends StatelessWidget {
  const CustomFinancialDetailsUi({super.key, required this.s});

  final DailySummaryModel s;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('ملخص', style: AppStyle.style20W500),
        Expanded(
          child: CustomContainerStatistics(
            padding: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('الاشتراكات الجديدة'),
                      SizedBox(width: 40),
                      Text(s.newSubscriptions.toString()),
                      SizedBox(width: 20),
                      ElevatedButton(onPressed: () {}, child: Text('View')),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text('تجديدات'),
                      SizedBox(width: 40),
                      Text('${s.renewals}'),
                      SizedBox(width: 20),
                      ElevatedButton(onPressed: () {}, child: Text('View')),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text('الدخل'),
                      SizedBox(width: 40),
                      Text('${s.income}'),
                      SizedBox(width: 50),
                      Text('الخوارج'),
                      SizedBox(width: 40),
                      Text('${s.expense}'),
                      SizedBox(width: 20),
                      ElevatedButton(onPressed: () {}, child: Text('View')),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text('total'),
                      SizedBox(width: 40),
                      Text('${s.total}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
