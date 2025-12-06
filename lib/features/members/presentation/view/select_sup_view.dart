import 'package:flutter/material.dart';
import 'package:power_gym/features/members/presentation/view/widget/select_sub.dart';

class SelectSupView extends StatelessWidget {
  const SelectSupView({super.key});

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
          const SelectSup(),
        ],
      ),
    );
  }
}
