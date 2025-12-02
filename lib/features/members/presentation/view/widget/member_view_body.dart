import 'package:flutter/material.dart';
import 'package:power_gym/features/home/presentation/view/widget/custom_drawer.dart';
import 'package:power_gym/features/members/presentation/view/widget/member_body.dart';

class MemberViewBody extends StatelessWidget {
  const MemberViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Row(
        children: [
          Expanded(flex: 1, child: CustomDrawer()),
          Expanded(flex: 3, child: MemberBody()),
        ],
      ),
    );
  }
}
