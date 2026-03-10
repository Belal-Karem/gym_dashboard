import 'package:flutter/material.dart';

class MemberTile extends StatelessWidget {
  const MemberTile({super.key, required this.onTap, required this.memberName});
  final Function() onTap;
  final String memberName;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(memberName), onTap: () => onTap());
  }
}
