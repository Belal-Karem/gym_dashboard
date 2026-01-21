import 'package:power_gym/features/report/data/models/model/subscription_view_item.dart';

abstract class SubscriptionListState {}

class SubscriptionListInitial extends SubscriptionListState {}

class SubscriptionListLoading extends SubscriptionListState {}

class SubscriptionListLoaded extends SubscriptionListState {
  final List<SubscriptionViewItem> items;

  SubscriptionListLoaded(this.items);
}

class SubscriptionListError extends SubscriptionListState {
  final String message;
  SubscriptionListError(this.message);
}
