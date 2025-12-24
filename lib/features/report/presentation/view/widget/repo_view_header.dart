import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/report/data/models/repo/daily_summary_repo.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_summary_cubit.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/report_filter_cubit.dart';
import 'package:power_gym/features/report/presentation/view/widget/custom_financial_details.dart';
import 'package:power_gym/features/report/presentation/view/widget/custom_overview.dart';

class RepoViewHeader extends StatelessWidget {
  const RepoViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          CustomOverview(),
          Expanded(child: CustomFinancialDetails()),
        ],
      ),
    );
  }
}
