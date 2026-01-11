import 'package:flutter/material.dart';

class TextBouttonMemberInfo extends StatelessWidget {
  const TextBouttonMemberInfo({super.key, required this.text, this.onPressed});

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 15)),
      ),
    );
  }
}
