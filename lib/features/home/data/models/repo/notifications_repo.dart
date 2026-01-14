import 'package:power_gym/features/home/data/models/model/app_notification_mode.dart';

abstract class NotificationsRepo {
  Stream<List<AppNotification>> getNotificationsStream(String memberId);
}
