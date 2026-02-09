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
      title: Text('الاعضاء', style: TextStyle(fontSize: 20)),
      routerPath: AppRouter.kmemberview,
    ),
    DrawerItemModel(
      icon: Icon(FontAwesomeIcons.userGroup),
      title: Text('المدربون', style: TextStyle(fontSize: 20)),
      routerPath: AppRouter.ktrainerview,
    ),
    DrawerItemModel(
      icon: Icon(FontAwesomeIcons.calendar),
      title: Text('الاشتراكات', style: TextStyle(fontSize: 20)),
      routerPath: AppRouter.ksubscriptionsview,
    ),
    DrawerItemModel(
      icon: Icon(FontAwesomeIcons.moneyCheckDollar),
      title: Text('المدفوعات', style: TextStyle(fontSize: 20)),
      routerPath: AppRouter.kpaymentview,
    ),
    DrawerItemModel(
      icon: Icon(FontAwesomeIcons.cube),
      title: Text('الاشتراكات Pt', style: TextStyle(fontSize: 20)),
      routerPath: AppRouter.kplanview,
    ),
    DrawerItemModel(
      icon: Icon(Icons.assignment),
      title: Text('التقرير اليومي', style: TextStyle(fontSize: 20)),
      routerPath: AppRouter.kreportview,
    ),
    DrawerItemModel(
      icon: Icon(Icons.settings),
      title: Text('الاعدادات', style: TextStyle(fontSize: 20)),
      routerPath: AppRouter.ksettingview,
    ),
  ];
}
