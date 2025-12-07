part of 'subscriptions_cubit.dart';

abstract class SubscriptionsState {}

class SubscriptionsInitial extends SubscriptionsState {}

class SubscriptionsLoading extends SubscriptionsState {}

class SubscriptionsSuccess extends SubscriptionsState {
  final List<MemberSubscriptionModel> subscriptions;
  SubscriptionsSuccess(this.subscriptions);
}

class SubscriptionsFailure extends SubscriptionsState {
  final String message;
  SubscriptionsFailure(this.message);
}

class SubscriptionAdded extends SubscriptionsState {}
