import 'package:flutter/material.dart';

class LogoAndName extends StatelessWidget {
  const LogoAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/image/image.png', height: 170, width: 170),
        Text('Power House Gym', style: TextStyle(fontSize: 30)),
      ],
    );
  }
}
