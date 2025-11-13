import 'package:flutter/material.dart';
import 'package:power_gym/features/report/presentation/view/widget/report_view_body.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/image/image.png', height: 120, width: 120),
              Text('Power House Gym', style: TextStyle(fontSize: 20)),
            ],
          ),
          Expanded(child: ReportViewBody()),
        ],
      ),
    );
  }
}
