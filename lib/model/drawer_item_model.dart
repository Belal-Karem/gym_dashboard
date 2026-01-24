import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_gym/core/utils/app_router.dart';

class DrawerItemModel {
  final Icon icon;
  final Text title;
  final String routerPath;

  const DrawerItemModel({
    required this.icon,
    required this.title,
    required this.routerPath,
  });

  static const List<DrawerItemModel> drawerItemList = [
    DrawerItemModel(
      icon: Icon(Icons.home),
      title: Text('لوحة التحكم', style: TextStyle(fontSize: 20)),

      routerPath: AppRouter.khomeview,
    ),
    DrawerItemModel(
      icon: Icon(FontAwesomeIcons.user),
      title: Text(style: TextStyle(fontSize: 20), 'الاعضاء'),
      routerPath: AppRouter.kmemberview,
    ),
    DrawerItemModel(
      icon: Icon(FontAwesomeIcons.userGroup),
      title: Text(style: TextStyle(fontSize: 20), 'المدربون'),
      routerPath: AppRouter.ktrainerview,
    ),
    DrawerItemModel(
      icon: Icon(FontAwesomeIcons.calendar),
      title: Text(style: TextStyle(fontSize: 20), 'الاشتراكات'),
      routerPath: AppRouter.ksubscriptionsview,
    ),
    DrawerItemModel(
      icon: Icon(FontAwesomeIcons.moneyCheckDollar),
      title: Text(style: TextStyle(fontSize: 20), 'المدفوعات'),
      routerPath: AppRouter.kpaymentview,
    ),
    DrawerItemModel(
      icon: Icon(FontAwesomeIcons.cube),
      title: Text(style: TextStyle(fontSize: 20), 'الاشتراكات Pt'),
      routerPath: AppRouter.kplanview,
    ),
    DrawerItemModel(
      icon: Icon(Icons.assignment),
      title: Text(style: TextStyle(fontSize: 20), 'التقرير اليومي'),
      routerPath: AppRouter.kreportview,
    ),
    DrawerItemModel(
      icon: Icon(Icons.settings),
      title: Text(style: TextStyle(fontSize: 20), 'الاعدادات'),
      routerPath: AppRouter.ksettingview,
    ),
  ];
}
