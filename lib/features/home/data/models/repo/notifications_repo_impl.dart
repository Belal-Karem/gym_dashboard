import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/home/data/models/model/app_notification_mode.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';

class NotificationsRepoImpl {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference subsRef = FirebaseFirestore.instance.collection(
    kmembersubscriptionsCollections,
  );

  /// Stream لجميع الإشعارات بناء على كل الاشتراكات
  Stream<List<AppNotification>> getNotificationsStream() {
    return subsRef.snapshots().asyncMap((snapshot) async {
      final List<AppNotification> notifications = [];
      final today = DateUtils.dateOnly(DateTime.now());

      for (final doc in snapshot.docs) {
        final sub = MemberSubscriptionModel.fromJson(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );

        final endDate = DateUtils.dateOnly(sub.endDate);
        final remainingDays = endDate.difference(today).inDays - 1;

        if (remainingDays < 1 || remainingDays > 3) continue;

        final memberDoc = await _firestore
            .collection(kMemberCollections)
            .doc(sub.memberId)
            .get();
        if (!memberDoc.exists) continue;

        final memberName = memberDoc[kname];
        final memberId = memberDoc[kmemberid];

        String body;

        if (remainingDays == 1) {
          body = 'اشتراك ($memberName : id $memberId) ينتهي بكرة';
        } else {
          body =
              'اشتراك ($memberName  :id $memberId) ينتهي خلال $remainingDays أيام';
        }

        notifications.add(
          AppNotification(id: sub.id, title: 'تنبيه اشتراك', body: body),
        );
      }
      return notifications;
    });
  }
}
