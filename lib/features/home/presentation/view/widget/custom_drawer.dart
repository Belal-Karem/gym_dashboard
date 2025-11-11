import 'package:flutter/material.dart';
import 'package:power_gym/features/home/presentation/view/widget/custom_drawer_item_list_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(child: const CustomDrawerItemListView())),
      ],
    );
  }
}
