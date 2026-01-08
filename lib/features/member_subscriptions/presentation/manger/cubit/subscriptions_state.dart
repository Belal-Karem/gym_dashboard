part of 'subscriptions_cubit.dart';

abstract class MemberSubscriptionState {}

class MemberSubscriptionInitial extends MemberSubscriptionState {}

class MemberSubscriptionLoading extends MemberSubscriptionState {}

/// اشتراك نشط + الخطة
class MemberSubscriptionLoaded extends MemberSubscriptionState {
  final MemberSubscriptionModel subscription;
  final SubModel plan;

  MemberSubscriptionLoaded({required this.subscription, required this.plan});
}

/// لا يوجد اشتراك (حالة طبيعية)
class MemberSubscriptionEmpty extends MemberSubscriptionState {}

/// إضافة اشتراك
class MemberSubscriptionAddSuccess extends MemberSubscriptionState {}

/// تحديث (حضور – تجديد – فريز)
class MemberSubscriptionUpdateSuccess extends MemberSubscriptionState {}

/// خطأ حقيقي
class MemberSubscriptionFailure extends MemberSubscriptionState {
  final String message;

  MemberSubscriptionFailure(this.message);
}

/// اشتراكات نشطة لكل الأعضاء
class MembersSubscriptionLoaded extends MemberSubscriptionState {
  final Map<String, MemberSubscriptionModel> subscription;

  MembersSubscriptionLoaded(this.subscription);
}
