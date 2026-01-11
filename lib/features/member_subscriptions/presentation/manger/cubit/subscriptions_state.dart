part of 'subscriptions_cubit.dart';

abstract class MemberSubscriptionState {}

class MemberSubscriptionInitial extends MemberSubscriptionState {}

class MemberSubscriptionLoading extends MemberSubscriptionState {}

/// تحميل اشتراكات عضو
class MemberSubscriptionLoaded extends MemberSubscriptionState {
  final MemberSubscriptionModel subscription;
  final SubModel plan;

  MemberSubscriptionLoaded({required this.subscription, required this.plan});
}

/// ✅ ADDED: Missing Empty State
class MemberSubscriptionEmpty extends MemberSubscriptionState {}

/// إضافة اشتراك
class MemberSubscriptionAddSuccess extends MemberSubscriptionState {}

/// تحديث (تجديد – فريز – حضور)
class MemberSubscriptionUpdateSuccess extends MemberSubscriptionState {}

/// خطأ
class MemberSubscriptionFailure extends MemberSubscriptionState {
  final String message;

  MemberSubscriptionFailure(this.message);
}

class MembersSubscriptionLoaded extends MemberSubscriptionState {
  final Map<String, MemberSubscriptionModel> subscription;

  MembersSubscriptionLoaded(this.subscription);
}
