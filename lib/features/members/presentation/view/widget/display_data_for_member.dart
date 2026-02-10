import 'package:flutter/material.dart';
import 'package:power_gym/features/members/presentation/view/widget/item_display_data_for_member.dart';

class DisplayDataForMember extends StatelessWidget {
  const DisplayDataForMember({
    super.key,
    required this.label,
    this.child,
    this.child2,
  });

  final String label;
  final String? child, child2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withAlpha(150)),
      ),
      child: Column(
        children: [
          ItemDisplayDataForMember(
            label: label,
            child: child,
            child2: child2 ?? '',
          ),
        ],
      ),
    );
  }
}
