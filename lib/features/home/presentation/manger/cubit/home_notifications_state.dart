import 'package:power_gym/features/home/data/models/model/app_notification_mode.dart';

abstract class HomeNotificationsState {
  const HomeNotificationsState();
}

class HomeNotificationsInitial extends HomeNotificationsState {
  const HomeNotificationsInitial();
}

class HomeNotificationsLoading extends HomeNotificationsState {
  const HomeNotificationsLoading();
}

class HomeNotificationsLoaded extends HomeNotificationsState {
  final List<AppNotification> notifications;

  const HomeNotificationsLoaded(this.notifications);
}

class HomeNotificationsError extends HomeNotificationsState {
  final String message;

  const HomeNotificationsError(this.message);
}
