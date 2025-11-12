import 'package:flutter/material.dart';
import 'package:power_gym/features/members/presentation/view/widget/member_view_body.dart';

class MemberView extends StatelessWidget {
  const MemberView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/image/power-house-gym-gudi-malkapur-hyderabad-gyms-16vu3c2eru-removebg-preview.png',
                height: 120,
                width: 120,
              ),
              Text('Power House Gym', style: TextStyle(fontSize: 20)),
            ],
          ),
          MemberViewBody(),
        ],
      ),
    );
  }
}
