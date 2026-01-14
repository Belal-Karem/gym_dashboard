import 'package:bloc/bloc.dart';
import 'package:power_gym/features/home/presentation/view/widget/show_dialog_data_Member_info.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/member_subscriptions_repo.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/plans_repo.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

part 'subscriptions_state.dart';

class MemberSubscriptionCubit extends Cubit<MemberSubscriptionState> {
  final MemberSubscriptionsRepo repo;
  final PlansRepo plansRepo;

  MemberSubscriptionCubit(this.repo, this.plansRepo)
    : super(MemberSubscriptionInitial());

  /// إضافة اشتراك جديد
  Future<void> addSubscription(MemberSubscriptionModel model) async {
    emit(MemberSubscriptionLoading());

    final updatedModel = _recalculateSubscription(model);

    final result = await repo.addMemberSubscription(updatedModel);

    result.fold(
      (failure) => emit(MemberSubscriptionFailure(failure.message)),
      (_) => emit(MemberSubscriptionAddSuccess()),
    );
  }

  /// جلب اشتراك العضو الحالي
  Future<void> getMemberSubscriptions(String memberId) async {
    emit(MemberSubscriptionLoading());

    final result = await repo.getSubscriptionsByMember(memberId);
    print(result);

    result.fold((failure) => emit(MemberSubscriptionFailure(failure.message)), (
      list,
    ) async {
      if (list.isEmpty) {
        emit(MemberSubscriptionEmpty());
        return;
      }

      final recalculated = list.map(_recalculateSubscription).toList();

      MemberSubscriptionModel? activeSub;

      final validSubs = recalculated
          .where(
            (s) =>
                s.status == SubscriptionStatus.active ||
                s.status == SubscriptionStatus.frozen,
          )
          .toList();

      if (validSubs.isEmpty) {
        emit(MemberSubscriptionEmpty());
        return;
      }

      activeSub = validSubs.first;

      final planResult = await plansRepo.getPlanById(activeSub.subscriptionId);

      planResult.fold(
        (failure) => emit(MemberSubscriptionFailure(failure.message)),
        (plan) => emit(
          MemberSubscriptionLoaded(subscription: activeSub!, plan: plan),
        ),
      );
    });
  }

  /// تجديد الاشتراك
  Future<void> renewSubscription(
    MemberSubscriptionModel oldSub,
    SubModel newPlan,
  ) async {
    emit(MemberSubscriptionLoading());

    final startDate = oldSub.endDate.isAfter(DateTime.now())
        ? oldSub.endDate
        : DateTime.now();

    final endDate = startDate.add(Duration(days: newPlan.durationDays));

    final renewed = oldSub.copyWith(
      startDate: startDate,
      endDate: endDate,
      remainingDays: endDate.difference(DateTime.now()).inDays,
      attendance: 0,
    );

    final result = await repo.updateMemberSubscription(renewed);

    result.fold(
      (failure) => emit(MemberSubscriptionFailure(failure.message)),
      (_) => emit(MemberSubscriptionUpdateSuccess()),
    );
  }

  /// تطبيق فريز
  Future<void> applyFreeze({
    required MemberSubscriptionModel subscription,
    required int freezeDays,
  }) async {
    if (subscription.status != SubscriptionStatus.active) {
      emit(MemberSubscriptionFailure('الاشتراك غير نشط'));
      return;
    }

    final updated = subscription.copyWith(
      endDate: subscription.endDate.add(Duration(days: freezeDays)),
      status: SubscriptionStatus.frozen,
    );

    final result = await repo.updateMemberSubscription(updated);

    result.fold(
      (failure) => emit(MemberSubscriptionFailure(failure.message)),
      (_) => (_) async {
        await getMemberSubscriptions(subscription.memberId);
      },
    );
  }

  /// تسجيل حضور
  Future<void> markAttendance({
    required MemberSubscriptionModel subscription,
    required SubModel plan,
  }) async {
    // 1️⃣ تحقق الاشتراك
    if (subscription.status != SubscriptionStatus.active) {
      emit(MemberSubscriptionFailure('الاشتراك غير نشط'));
      return;
    }

    if (subscription.attendance >= plan.maxAttendance) {
      emit(MemberSubscriptionFailure('تم الوصول للحد الأقصى للحضور'));
      return;
    }

    emit(MemberSubscriptionLoading());

    // 2️⃣ تحديث الحضور
    final updated = subscription.copyWith(
      attendance: subscription.attendance + 1,
    );

    final result = await repo.updateMemberSubscription(updated);

    result.fold(
      // ❌ فشل
      (failure) {
        emit(MemberSubscriptionFailure(failure.message));
      },

      // ✅ نجاح
      (_) async {
        await getMemberSubscriptions(subscription.memberId);

        emit(
          MemberSubscriptionAttendanceSuccess(
            subscription: updated,
            plan: plan,
          ),
        );
      },
    );
  }

  /// إعادة حساب الاشتراك
  MemberSubscriptionModel _recalculateSubscription(
    MemberSubscriptionModel sub,
  ) {
    final remaining = sub.endDate.difference(DateTime.now()).inDays;

    if (remaining <= 0) {
      return sub.copyWith(remainingDays: 0, status: SubscriptionStatus.expired);
    }

    return sub.copyWith(
      remainingDays: remaining,
      status: sub.status == SubscriptionStatus.frozen
          ? SubscriptionStatus.frozen
          : SubscriptionStatus.active,
    );
  }

  Future<void> useInvitation(MemberSubscriptionModel subscription) async {
    // ✅ TODO: Implement invitation logic
    final updated = subscription.copyWith(
      // هنا تزود logic الخصم أو العد
    );

    final result = await repo.updateMemberSubscription(updated);

    result.fold(
      (failure) => emit(MemberSubscriptionFailure(failure.message)),
      (_) => (_) async {
        await getMemberSubscriptions(subscription.memberId);
      },
    );
  }

  /// تحميل الاشتراكات النشطة لكل الأعضاء
  Future<void> loadMembersActiveSubscriptions(List<MemberModel> members) async {
    emit(MemberSubscriptionLoading());

    final Map<String, MemberSubscriptionModel> result = {};

    for (final member in members) {
      final response = await repo.getSubscriptionsByMember(member.id);

      response.fold((_) {}, (subs) {
        final active = subs
            .map(_recalculateSubscription)
            .where((s) => s.status == SubscriptionStatus.active)
            .toList();

        if (active.isNotEmpty) {
          result[member.id] = active.first;
        }
      });
    }

    emit(MembersSubscriptionLoaded(result));
  }
}
