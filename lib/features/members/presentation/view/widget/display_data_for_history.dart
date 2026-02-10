import 'package:flutter/material.dart';
import 'package:power_gym/features/members/presentation/view/widget/item_display_data_for_history.dart';

class DisplayDataForHistory extends StatelessWidget {
  const DisplayDataForHistory({
    super.key,
    required this.label,
    this.child,
    this.child2,
    this.style,
  });
  final String label;
  final String? child, child2;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withAlpha(150)),
      ),
      child: Column(
        children: [
          ItemDisplayDataForHistory(
            label: label,
            child: child,
            child2: child2 ?? '',
            style: style,
          ),
        ],
      ),
    );
  }
}
