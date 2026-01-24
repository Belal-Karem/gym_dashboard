import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/gradient_scaffold.dart';
import 'package:power_gym/features/home/presentation/view/widget/home_view_body.dart';
import 'package:power_gym/features/home/presentation/view/widget/logo_and_name.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          Row(children: [LogoAndName()]),
          HomeViewBody(),
        ],
      ),
    );
  }
}



// class AdaptiveLayoutWidget extends StatelessWidget {
//   const AdaptiveLayoutWidget({super.key, required this.mobileLayout, required this.tabletLayout, required this.desktopLayout});

//   final WidgetBuilder mobileLayout, tabletLayout, desktopLayout;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       if(constraints.maxWidth <800 ){
//         return
//       }
//     },);
//   }
// }