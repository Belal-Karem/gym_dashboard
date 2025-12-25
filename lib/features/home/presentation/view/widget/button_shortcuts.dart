import 'package:flutter/material.dart';

class ButtonShortcuts extends StatelessWidget {
  const ButtonShortcuts({
    super.key,
    required this.fontAwesomeIcons,
    this.onTap,
  });

  final IconData fontAwesomeIcons;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(200),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(200),
          ),
          color: Color(0xff9D1D1E),
        ),
        child: Icon(fontAwesomeIcons, color: Colors.black),
      ),
    );
  }
}
