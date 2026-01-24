import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/app_init/cubit/app_init_cubit.dart';
import 'package:power_gym/core/app_init/cubit/app_init_state.dart';

// class AppBootstrap extends StatelessWidget {
//   final Widget child;

//   const AppBootstrap({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AppInitCubit, AppInitState>(
//       builder: (context, state) {
//         if (state is AppInitLoading) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         // 🔹 Error
//         if (state is AppInitError) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text(state.message)));
//           });

//           return const Scaffold(
//             body: Center(child: Text('حدث خطأ، حاول مرة أخرى')),
//           );
//         }
//         return child;
//       },
//     );
//   }
// }
