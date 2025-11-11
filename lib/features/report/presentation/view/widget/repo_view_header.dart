import 'package:flutter/material.dart';
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
