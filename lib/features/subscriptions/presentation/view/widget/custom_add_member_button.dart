import 'package:flutter/material.dart';

class CustomAddMemberButton extends StatelessWidget {
  const CustomAddMemberButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffBD4244),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      ),
      onPressed: () {
        return print('===add');
      },
      child: Text('Add Subscriptions'),
    );
  }
}
