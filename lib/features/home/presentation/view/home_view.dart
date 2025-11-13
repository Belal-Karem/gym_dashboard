import 'package:flutter/material.dart';
import 'package:power_gym/features/home/presentation/view/widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/image/image.png', height: 120, width: 120),
              Text('Power House Gym', style: TextStyle(fontSize: 20)),
            ],
          ),
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