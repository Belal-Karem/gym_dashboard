import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
  });
  final String text;
  final void Function()? onPressed;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Color(0xff9D1D1E),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppStyle.styleboldwhite70.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
