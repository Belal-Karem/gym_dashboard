import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/gradient_scaffold.dart';
import 'package:power_gym/features/home/presentation/view/widget/logo_and_name.dart';
import 'package:power_gym/features/settings/presentation/view/widget/setting_view_body.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          Row(children: [LogoAndName()]),
          Expanded(child: SettingViewBody()),
        ],
      ),
    );
  }
}
