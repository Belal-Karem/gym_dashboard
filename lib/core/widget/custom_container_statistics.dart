import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';

class CustomContainerStatistics extends StatelessWidget {
  const CustomContainerStatistics({
    super.key,
    required this.child,
    this.padding = 15,
  });

  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kprimaryColor,
        ),
        child: Padding(padding: EdgeInsets.all(15), child: child),
      ),
    );
  }
}
