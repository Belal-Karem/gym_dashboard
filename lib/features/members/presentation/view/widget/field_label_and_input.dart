import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';

class FieldLabelAndInput extends StatelessWidget {
  const FieldLabelAndInput({
    super.key,
    required this.label,
    required this.child,
  });
  final String label;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyle.style20W500),
        const SizedBox(height: 5),
        child,
        const SizedBox(height: 15),
      ],
    );
  }
}
