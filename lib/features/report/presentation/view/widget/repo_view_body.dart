import 'package:flutter/material.dart';
import 'package:power_gym/features/report/presentation/view/widget/repo_view_header.dart';
import 'package:power_gym/features/report/presentation/view/widget/custom_presence.dart';
import 'package:power_gym/features/report/presentation/view/widget/repo_view_body_app_bar.dart';

class RepoViewBody extends StatelessWidget {
  const RepoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RepoViewBodyAppBar(),
          SizedBox(height: 40),
          RepoViewHeader(),
          SizedBox(height: 40),
          CustomPresence(),
        ],
      ),
    );
  }
}
