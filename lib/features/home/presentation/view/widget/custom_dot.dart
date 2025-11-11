import 'package:flutter/material.dart';

class CustomNotificationsInt extends StatelessWidget {
  const CustomNotificationsInt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xff2A2B30),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Container(
          width: 12,
          height: 12,
          decoration: ShapeDecoration(
            color: Color(0xffC93835),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
          ),
        ),
        title: Text('Membership expires tomorrow'),
      ),
    );
  }
}
