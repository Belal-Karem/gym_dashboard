import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/report/data/models/model/subscription_view_item.dart';

abstract class SubscriptionReportRepo {
  Future<List<MemberSubscriptionModel>> getNewSubscriptions(String dateId);
  Future<List<MemberSubscriptionModel>> getRenewedSubscriptions(String dateId);
  Future<List<SubscriptionViewItem>> getSubscriptionsForDate(
    String dateId,
    bool isRenewal,
  );

  // Future<SubscriptionReportResult> getDayReport(String dateId);
}
