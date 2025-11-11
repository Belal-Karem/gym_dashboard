import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:power_gym/features/home/presentation/view/widget/custom_drawer_item.dart';
import 'package:power_gym/model/drawer_item_model.dart';

class CustomDrawerItemListView extends StatefulWidget {
  const CustomDrawerItemListView({super.key});

  @override
  State<CustomDrawerItemListView> createState() =>
      _CustomDrawerItemListViewState();
}

class _CustomDrawerItemListViewState extends State<CustomDrawerItemListView> {
  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();
    return ListView.builder(
      itemCount: DrawerItemModel.drawerItemList.length,
      itemBuilder: (context, index) {
        final item = DrawerItemModel.drawerItemList[index];
        final isActive = currentPath == item.routerPath;
        return GestureDetector(
          onTap: () {
            if (!isActive) {
              context.go(item.routerPath);
            }
          },
          child: CustomDrawerItem(isActive: isActive, drawerItemModel: item),
        );
      },
    );
  }
}
// class CustomDrawerItemListView extends StatefulWidget {
//   const CustomDrawerItemListView({super.key});
//   @override
//   State<CustomDrawerItemListView> createState() =>
//       _CustomDrawerItemListViewState();
// }

// class _CustomDrawerItemListViewState extends State<CustomDrawerItemListView> {
//   int isActiveindex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: DrawerItemModel.drawerItemList.length,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               isActiveindex = index;
//             });
//           },
//           child: CustomDrawerItem(
//             isActive: isActiveindex == index,
//             drawerItemModel: DrawerItemModel.drawerItemList[index],
//           ),
//         );
//       },
//     );
//   }
// }
