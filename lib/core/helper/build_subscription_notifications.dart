// List<AppNotification> buildSubscriptionNotifications(
//   List<MemberSubscriptionModel> subscriptions,
// ) {
//   final today = DateUtils.dateOnly(DateTime.now());
//   final List<AppNotification> notifications = [];

//   for (final sub in subscriptions) {
//     final endDate = DateUtils.dateOnly(sub.endDate);
//     final remainingDays = endDate.difference(today).inDays;

//     if (remainingDays >= 0 && remainingDays <= 3) {
//       String body;

//       if (remainingDays == 0) {
//         body = 'اشتراك ${sub.status} ينتهي اليوم';
//       } else if (remainingDays == 1) {
//         body = 'اشتراك ${sub.status} هينتهي بكرة';
//       } else {
//         body = 'اشتراك ${sub.status} هينتهي خلال $remainingDays أيام';
//       }

//       notifications.add(AppNotification(title: 'تنبيه اشتراك', body: body));
//     }
//   }

//   return notifications;
// }
