import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/assets.dart';

class LogoAndName extends StatelessWidget {
  const LogoAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15),
        Image.asset(Assets.assetsImageLogo, width: 80, height: 80),
        const SizedBox(width: 15),
        Text(
          ' House Power',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
