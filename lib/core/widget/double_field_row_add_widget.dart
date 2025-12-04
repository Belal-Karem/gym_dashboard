import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/field_label_and_input_add_widget.dart';

class DoubleFieldRowAddWidget extends StatelessWidget {
  const DoubleFieldRowAddWidget({
    super.key,
    required this.leftLabel,
    required this.leftChild,
    required this.rightLabel,
    this.rightChild,
  });

  final String leftLabel, rightLabel;
  final Widget? leftChild, rightChild;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FieldLabelAndInputAddWidget(
            label: leftLabel,
            child: leftChild ?? const SizedBox(),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: FieldLabelAndInputAddWidget(
            label: rightLabel,
            child: rightChild ?? const SizedBox(),
          ),
        ),
      ],
    );
  }
}
