import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/home_notifications_cubit.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/home_notifications_state.dart';
import 'package:power_gym/features/home/presentation/view/widget/custom_dot.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// العنوان
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                const Text(
                  'إشعارات',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: ShapeDecoration(
                    color: const Color(0xff2A2B30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // لاحقًا: clear notifications
                    },
                    icon: const Icon(
                      Icons.delete_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          BlocBuilder<HomeNotificationsCubit, HomeNotificationsState>(
            builder: (context, state) {
              if (state is HomeNotificationsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HomeNotificationsLoaded) {
                if (state.notifications.isEmpty) {
                  return const Text('لا توجد إشعارات حاليًا');
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: state.notifications.length,
                    itemBuilder: (context, index) {
                      final n = state.notifications[index];
                      return CustomNotificationsInt(
                        text: n.body,

                        onDelete: () {
                          context
                              .read<HomeNotificationsCubit>()
                              .deleteNotification(n.id);
                        },
                      );
                    },
                  ),
                );
              }
              if (state is HomeNotificationsError) {
                return Text('حدث خطأ: ${state.message}');
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
