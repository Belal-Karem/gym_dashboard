import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/model/drawer_item_model.dart';

class ActiveDrawerItem extends StatelessWidget {
  const ActiveDrawerItem({super.key, required this.drawerItemModel});

  final DrawerItemModel drawerItemModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
          color: kprimaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: drawerItemModel.icon,
          title: drawerItemModel.title,
        ),
      ),
    );
  }
}

class InActiveDrawerItem extends StatelessWidget {
  const InActiveDrawerItem({super.key, required this.drawerItemModel});

  final DrawerItemModel drawerItemModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        child: ListTile(
          leading: drawerItemModel.icon,
          title: drawerItemModel.title,
        ),
      ),
    );
  }
}
