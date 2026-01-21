import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/report/data/models/model/subscription_view_item.dart';
import 'package:power_gym/features/report/data/models/repo/subscription_report_repo.dart';

class SubscriptionReportRepoImpl implements SubscriptionReportRepo {
  final FirebaseFirestore firestore;

  SubscriptionReportRepoImpl(this.firestore);

  @override
  Future<List<MemberSubscriptionModel>> getNewSubscriptions(
    String dateId,
  ) async {
    final snap = await firestore
        .collection(kmembersubscriptionsCollections)
        .where('dateIdForReport', isEqualTo: dateId)
        .where('isRenewal', isEqualTo: false)
        .get();

    return snap.docs
        .map((doc) => MemberSubscriptionModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<List<MemberSubscriptionModel>> getRenewedSubscriptions(
    String dateId,
  ) async {
    final snap = await firestore
        .collection(kmembersubscriptionsCollections)
        .where('dateIdForReport', isEqualTo: dateId)
        .where('isRenewal', isEqualTo: true)
        .get();
    return snap.docs
        .map((doc) => MemberSubscriptionModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  Future<List<SubscriptionViewItem>> getSubscriptionsForDate(
    String dateId,
    bool isRenewal,
  ) async {
    final subsSnap = await firestore
        .collection(kmembersubscriptionsCollections)
        .where('dateIdForReport', isEqualTo: dateId)
        .where('isRenewal', isEqualTo: isRenewal)
        .get();

    if (subsSnap.docs.isEmpty) return [];

    final memberIds = subsSnap.docs
        .map((e) => e['memberId'] as String)
        .toSet()
        .toList();

    final membersSnap = await firestore
        .collection(kMemberCollections)
        .where(FieldPath.documentId, whereIn: memberIds)
        .get();

    final membersMap = {for (final doc in membersSnap.docs) doc.id: doc.data()};

    return subsSnap.docs.map((subDoc) {
      final memberData = membersMap[subDoc['memberId']];

      return SubscriptionViewItem(
        memberName: memberData?['name'] ?? 'غير معروف',
        memberPhone: memberData?['phone'] ?? '',
        planName: subDoc['subscriptionId'], // نعدّلها بعدين
        isRenewal: subDoc['isRenewal'] ?? false,
      );
    }).toList();
  }

  // @override
  // Future<SubscriptionReportResult> getDayReport(String dateId) async {
  //   final snap = await firestore
  //       .collection(kmembersubscriptionsCollections)
  //       .where('dateIdForReport', isEqualTo: dateId)
  //       .get();

  //   final newSubs = <MemberSubscriptionModel>[];
  //   final renewals = <MemberSubscriptionModel>[];

  //   for (final doc in snap.docs) {
  //     final model = MemberSubscriptionModel.fromJson(
  //       doc.data(),
  //       doc.id,
  //     );

  //     if (model.isRenewal) {
  //       renewals.add(model);
  //     } else {
  //       newSubs.add(model);
  //     }
  //   }

  //   return SubscriptionReportResult(
  //     newSubscriptions: newSubs,
  //     renewals: renewals,
  //   );
  // }
}
