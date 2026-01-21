import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';

abstract class SubscriptionReportState {}

class SubscriptionReportInitial extends SubscriptionReportState {}

class SubscriptionReportLoading extends SubscriptionReportState {}

class SubscriptionReportLoaded extends SubscriptionReportState {
  final List<MemberSubscriptionModel> newSubscriptions;
  final List<MemberSubscriptionModel> renewals;

  SubscriptionReportLoaded({
    required this.newSubscriptions,
    required this.renewals,
  });
}

class SubscriptionReportError extends SubscriptionReportState {
  final String message;

  SubscriptionReportError(this.message);
}
