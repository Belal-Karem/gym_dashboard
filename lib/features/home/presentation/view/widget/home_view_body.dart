import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/home/data/models/repo/notifications_repo_impl.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/home_notifications_cubit.dart';
import 'package:power_gym/features/home/presentation/view/widget/custom_drawer.dart';
import 'package:power_gym/features/home/presentation/view/widget/dashboard.dart';

import '../../../../../core/utils/service_locator.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(flex: 1, child: const CustomDrawer()),
          Expanded(
            flex: 3,
            child: BlocProvider(
              create: (_) =>
                  HomeNotificationsCubit(sl<NotificationsRepoImpl>())..start(),
              child: const Dashboard(),
            ),
          ),
        ],
      ),
    );
  }
}
