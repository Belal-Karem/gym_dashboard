import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/utils/date_utils.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/guest_visit_model.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/guest_visits_repo.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/member_subscriptions_repo.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/plans_repo.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

part 'subscriptions_state.dart';

class MemberSubscriptionCubit extends Cubit<MemberSubscriptionState> {
  final MemberSubscriptionsRepo repo;
  final GuestVisitsRepo guestVisitsRepo;
  final PlansRepo plansRepo;

  final Map<String, MemberSubscriptionModel> _cachedSubscriptions = {};
  final Map<String, SubModel> _plansCache = {};

  MemberSubscriptionCubit(this.repo, this.plansRepo, this.guestVisitsRepo)
    : super(MemberSubscriptionInitial());

  void _emitCache() {
    emit(MembersSubscriptionLoaded(Map.from(_cachedSubscriptions)));
  }

  Future<void> addSubscription(MemberSubscriptionModel model) async {
    final updated = _recalculateSubscription(model);

    final result = await repo.addMemberSubscription(updated);

    result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (_) {
      _cachedSubscriptions[model.memberId] = updated;

      emit(MembersSubscriptionLoaded(Map.from(_cachedSubscriptions)));

      emit(MemberSubscriptionAddSuccess());
    });
  }

  Future<void> renewOrExtendSubscription({
    required MemberSubscriptionModel currentSub,
    required SubModel plan,
  }) async {
    final now = DateTime.now();

    late MemberSubscriptionModel updated;

    if (currentSub.status == SubscriptionStatus.expired) {
      // 🔄 Renew
      updated = currentSub.copyWith(
        startDate: now,
        endDate: now.add(Duration(days: plan.durationDays)),
        attendance: 0,
        status: SubscriptionStatus.active,
        subscriptionId: plan.id,
        dateIdAttendance: null,
        dateIdForReport: generateDateId(now),
        isRenewal: true,
      );
    } else {
      updated = currentSub.copyWith(
        endDate: currentSub.endDate.add(Duration(days: plan.durationDays)),
        subscriptionId: plan.id,
        status: SubscriptionStatus.active,
        dateIdForReport: generateDateId(now),
        isRenewal: true,
      );
    }

    final recalculated = _recalculateSubscription(updated);

    final result = await repo.updateMemberSubscription(recalculated);

    result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (_) {
      _cachedSubscriptions[currentSub.memberId] = recalculated;
      _emitCache();

      emit(MemberSubscriptionAddSuccess());
    });
  }

  Future<void> getMemberSubscriptions(String memberId) async {
    final result = await repo.getSubscriptionsByMember(memberId);
    result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (list) {
      if (list.isEmpty) {
        _cachedSubscriptions.remove(memberId);
        _emitCache();
        return;
      }

      final recalculated = list.map(_recalculateSubscription).toList()
        ..sort((a, b) => b.endDate.compareTo(a.endDate));

      _cachedSubscriptions[memberId] = recalculated.first;
      checkFrozenSubscriptions();
      _emitCache();
    });
  }

  Future<void> loadMembersActiveSubscriptions(List<MemberModel> members) async {
    for (final member in members) {
      final response = await repo.getSubscriptionsByMember(member.id);
      response.fold((_) {}, (subs) {
        if (subs.isEmpty) return;

        final recalculated = subs.map(_recalculateSubscription).toList()
          ..sort((a, b) => b.endDate.compareTo(a.endDate));

        final latest = recalculated.first;

        if (latest.status != SubscriptionStatus.expired) {
          _cachedSubscriptions[member.id] = latest;
          checkFrozenSubscriptions();
        }
      });
    }

    _emitCache();
  }

  Future<Either<String, Unit>> markAttendance({
    required MemberSubscriptionModel subscription,
  }) async {
    try {
      final plan = await getPlan(subscription.subscriptionId);
      if (plan == null) {
        return Left('خطة الاشتراك غير موجودة');
      }

      if (subscription.status != SubscriptionStatus.active) {
        return Left('الاشتراك غير نشط');
      }

      final today = DateUtils.dateOnly(DateTime.now());
      final dateId = today.toIso8601String().split('T').first;

      if (subscription.dateIdAttendance == dateId) {
        return Left('تم تسجيل الحضور اليوم بالفعل');
      }

      if (subscription.attendance >= plan.maxAttendance) {
        return Left('تم الوصول للحد الأقصى للحضور');
      }

      final updated = subscription.copyWith(
        attendance: subscription.attendance + 1,
        dateIdAttendance: dateId,
      );

      final result = await repo.updateMemberSubscription(updated);

      if (result.isLeft()) {
        return Left(result.fold((f) => f.message, (_) => 'حدث خطأ'));
      }

      // تحديث الـ cache
      _cachedSubscriptions[subscription.memberId] = updated;
      _emitCache();

      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Unit>> applyFreeze({
    required MemberSubscriptionModel subscription,
    required int freezeDays,
  }) async {
    try {
      if (subscription.status != SubscriptionStatus.active) {
        return Left('الاشتراك غير نشط');
      }

      final freezeEnd = DateTime.now().add(Duration(days: freezeDays));

      final updated = subscription.copyWith(
        endDate: subscription.endDate.add(Duration(days: freezeDays)),
        status: SubscriptionStatus.frozen,
        freezeEndDate: freezeEnd,
      );

      final result = await repo.updateMemberSubscription(updated);

      if (result.isLeft()) {
        return Left(result.fold((f) => f.message, (_) => 'حدث خطأ'));
      }

      _cachedSubscriptions[subscription.memberId] = updated;
      _emitCache();

      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<void> checkFrozenSubscriptions() async {
    final subsList = _cachedSubscriptions.values.toList();

    for (var sub in subsList) {
      if (sub.status == SubscriptionStatus.frozen &&
          sub.freezeEndDate != null &&
          DateTime.now().isAfter(sub.freezeEndDate!)) {
        final updated = sub.copyWith(
          status: SubscriptionStatus.active,
          freezeEndDate: null,
        );

        final result = await repo.updateMemberSubscription(updated);

        result.fold(
          (f) => print('Failed to update subscription: ${f.message}'),
          (_) {
            _cachedSubscriptions[sub.memberId] = updated;
            _emitCache();
          },
        );
      }
    }
  }

  SubModel? getPlan(String planId) {
    if (_plansCache.containsKey(planId)) {
      return _plansCache[planId];
    }
    _loadPlan(planId);
    return null;
  }

  Future<void> _loadPlan(String planId) async {
    if (_plansCache.containsKey(planId)) return;

    final result = await plansRepo.getPlanById(planId);

    result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (plan) {
      _plansCache[planId] = plan;
      _emitCache();
    });
  }

  Future<Either<String, Unit>> useInvitation({
    required MemberSubscriptionModel subscription,
    required String guestName,
    String? guestPhone,
  }) async {
    try {
      if (subscription.status != SubscriptionStatus.active) {
        return Left('الاشتراك غير نشط');
      }

      final remaining =
          subscription.totalInvitations - subscription.usedInvitations;

      if (remaining <= 0) {
        return Left('لا يوجد دعوات متبقية');
      }

      final updated = subscription.copyWith(
        usedInvitations: subscription.usedInvitations + 1,
      );

      final result = await repo.updateMemberSubscription(updated);

      if (result.isLeft()) {
        return Left(result.fold((f) => f.message, (_) => '')); // ⚡ هنا
      }

      _cachedSubscriptions[subscription.memberId] = updated;
      _emitCache();

      final now = DateTime.now();

      final guestVisit = GuestVisitModel(
        id: '',
        hostMemberId: subscription.memberId,
        subscriptionId: subscription.id,
        guestName: guestName,
        guestPhone: guestPhone,
        checkInTime: now,
        dateId: generateDateId(now),
      );

      final visitResult = await guestVisitsRepo.addGuestVisit(guestVisit);

      return visitResult.fold((f) => Left(f.message), (_) => const Right(unit));
    } catch (e) {
      return Left(e.toString());
    }
  }

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

  Map<String, MemberSubscriptionModel> get cachedSubscriptions =>
      _cachedSubscriptions;
}
