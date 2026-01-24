import 'package:flutter/material.dart';
import 'package:power_gym/features/home/presentation/view/widget/custom_drawer.dart';

class SettingViewBody extends StatelessWidget {
  const SettingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(flex: 1, child: const CustomDrawer()),
          // Expanded(flex: 3, child: const SubscriptionsBody()),
        ],
      ),
    );
  }
}
