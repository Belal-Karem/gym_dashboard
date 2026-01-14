import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/home/data/models/model/app_notification_mode.dart';
import 'package:power_gym/features/home/data/models/repo/notifications_repo_impl.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/home_notifications_state.dart';

class HomeNotificationsCubit extends Cubit<HomeNotificationsState> {
  final NotificationsRepoImpl notificationsRepo;
  StreamSubscription? _sub;

  /// هنا نخزن قائمة Notifications الحالية
  List<AppNotification> currentNotifications = [];
  HomeNotificationsCubit(this.notificationsRepo)
    : super(const HomeNotificationsInitial());

  void start() {
    emit(const HomeNotificationsLoading());

    _sub?.cancel();
    _sub = notificationsRepo.getNotificationsStream().listen((notifications) {
      // هنا نخلي Notifications persistent
      // لو أي إشعار جديد موجود، نضيفه للقائمة
      for (var n in notifications) {
        if (!currentNotifications.any((e) => e.id == n.id)) {
          currentNotifications.add(n);
        }
      }
      emit(HomeNotificationsLoaded(List.from(currentNotifications)));
    }, onError: (e) => emit(HomeNotificationsError(e.toString())));
  }

  void deleteNotification(String id) {
    currentNotifications.removeWhere((n) => n.id == id);
    emit(HomeNotificationsLoaded(List.from(currentNotifications)));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
