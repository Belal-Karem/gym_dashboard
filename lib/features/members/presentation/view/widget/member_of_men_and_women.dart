import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';

class MemberOfMenAndWomen extends StatelessWidget {
  const MemberOfMenAndWomen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: CustomContainerStatistics(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '120',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  Text('أعضاء', style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ),

          Expanded(
            child: CustomContainerStatistics(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '120',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  Text('أعضاء', style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
