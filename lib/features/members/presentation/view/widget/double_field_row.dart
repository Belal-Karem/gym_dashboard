import 'package:flutter/material.dart';
import 'package:power_gym/features/members/presentation/view/widget/field_label_and_input.dart';

class DoubleFieldRow extends StatelessWidget {
  const DoubleFieldRow({
    super.key,
    required this.leftLabel,
    required this.leftChild,
    required this.rightLabel,
    required this.rightChild,
  });

  final String leftLabel, rightLabel;
  final Widget leftChild, rightChild;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FieldLabelAndInput(label: leftLabel, child: leftChild),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: FieldLabelAndInput(label: rightLabel, child: rightChild),
        ),
      ],
    );
  }
}
