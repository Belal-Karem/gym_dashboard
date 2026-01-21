import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/utils/date_utils.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/member_subscriptions_repo.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/plans_repo.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

part 'subscriptions_state.dart';

//
// class MemberSubscriptionCubit extends Cubit<MemberSubscriptionState> {
//   final MemberSubscriptionsRepo repo;
//   final PlansRepo plansRepo;

//   final Map<String, MemberSubscriptionModel> _cachedSubscriptions = {};
//   final Map<String, SubModel> _plansCache = {};

//   MemberSubscriptionCubit(this.repo, this.plansRepo)
//     : super(MemberSubscriptionInitial());

//   void _emitCache() {
//     emit(MembersSubscriptionLoaded(Map.from(_cachedSubscriptions)));
//   }

//   Future<void> addSubscription(MemberSubscriptionModel model) async {
//     final updated = _recalculateSubscription(model);

//     final result = await repo.addMemberSubscription(updated);

//     result.fold(
//       (f) => emit(MemberSubscriptionFailure(f.message)),
//       (_) => emit(MemberSubscriptionAddSuccess()),
//     );
//   }

//   Future<void> getMemberSubscriptions(String memberId) async {
//     final result = await repo.getSubscriptionsByMember(memberId);

//     result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (list) {
//       final valid = list
//           .map(_recalculateSubscription)
//           .where(
//             (s) =>
//                 s.status == SubscriptionStatus.active ||
//                 s.status == SubscriptionStatus.frozen,
//           )
//           .toList();

//       if (valid.isEmpty) {
//         _cachedSubscriptions.remove(memberId);
//       } else {
//         _cachedSubscriptions[memberId] = valid.first;
//       }

//       _emitCache();
//     });
//   }

//   Future<void> markAttendance({
//     required MemberSubscriptionModel subscription,
//   }) async {
//     final plan = await getPlan(subscription.subscriptionId);
//     if (plan == null) return;

//     final today = DateUtils.dateOnly(DateTime.now());
//     final dateId = today.toIso8601String().split('T').first;

//     if (subscription.dateIdAttendance == dateId) {
//       emit(MemberSubscriptionFailure('تم تسجيل الحضور اليوم بالفعل'));
//       return;
//     }

//     if (subscription.attendance >= plan.maxAttendance) {
//       emit(MemberSubscriptionFailure('تم الوصول للحد الأقصى للحضور'));
//       return;
//     }

//     final updated = subscription.copyWith(
//       attendance: subscription.attendance + 1,
//       dateIdAttendance: dateId,
//     );

//     final result = await repo.updateMemberSubscription(updated);

//     result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (_) {
//       _cachedSubscriptions[subscription.memberId] = updated;
//       _emitCache();

//       emit(
//         MemberSubscriptionAttendanceSuccess(subscription: updated, plan: plan),
//       );
//     });
//   }

//   Future<void> applyFreeze({
//     required MemberSubscriptionModel subscription,
//     required int freezeDays,
//   }) async {
//     if (subscription.status != SubscriptionStatus.active) {
//       emit(MemberSubscriptionFailure('الاشتراك غير نشط'));
//       return;
//     }

//     final updated = subscription.copyWith(
//       endDate: subscription.endDate.add(Duration(days: freezeDays)),
//       status: SubscriptionStatus.frozen,
//     );

//     final result = await repo.updateMemberSubscription(updated);

//     result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (_) {
//       _cachedSubscriptions[subscription.memberId] = updated;
//       _emitCache();
//     });
//   }

// Future<void> useInvitation(MemberSubscriptionModel subscription) async {
//   final updated = subscription.copyWith(
//     // TODO: invitation logic
//   );

//   final result = await repo.updateMemberSubscription(updated);

//   result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (_) {
//     _cachedSubscriptions[subscription.memberId] = updated;
//     _emitCache();
//   });
// }

//   Future<void> loadMembersActiveSubscriptions(List<MemberModel> members) async {
//     for (final member in members) {
//       final response = await repo.getSubscriptionsByMember(member.id);

//       response.fold((_) {}, (subs) {
//         final valid = subs
//             .map(_recalculateSubscription)
//             .where(
//               (s) =>
//                   s.status == SubscriptionStatus.active ||
//                   s.status == SubscriptionStatus.frozen,
//             )
//             .toList();

//         if (valid.isNotEmpty) {
//           _cachedSubscriptions[member.id] = valid.first;
//         }
//       });
//     }

//     _emitCache();
//   }

//   SubModel? getPlan(String planId) {
//     if (_plansCache.containsKey(planId)) {
//       return _plansCache[planId];
//     }

//     _loadPlan(planId);
//     return null;
//   }

//   Future<void> _loadPlan(String planId) async {
//     if (_plansCache.containsKey(planId)) return;

//     final result = await plansRepo.getPlanById(planId);

//     result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (plan) {
//       _plansCache[planId] = plan;

//       emit(MembersSubscriptionLoaded(Map.from(_cachedSubscriptions)));
//     });
//   }

//   MemberSubscriptionModel _recalculateSubscription(
//     MemberSubscriptionModel sub,
//   ) {
//     final remaining = sub.endDate.difference(DateTime.now()).inDays;

//     if (remaining <= 0) {
//       return sub.copyWith(remainingDays: 0, status: SubscriptionStatus.expired);
//     }

//     return sub.copyWith(
//       remainingDays: remaining,
//       status: sub.status == SubscriptionStatus.frozen
//           ? SubscriptionStatus.frozen
//           : SubscriptionStatus.active,
//     );
//   }

//   Map<String, MemberSubscriptionModel> get cachedSubscriptions =>
//       _cachedSubscriptions;
// }

class MemberSubscriptionCubit extends Cubit<MemberSubscriptionState> {
  final MemberSubscriptionsRepo repo;
  final PlansRepo plansRepo;

  final Map<String, MemberSubscriptionModel> _cachedSubscriptions = {};
  final Map<String, SubModel> _plansCache = {};

  MemberSubscriptionCubit(this.repo, this.plansRepo)
    : super(MemberSubscriptionInitial());

  void _emitCache() {
    emit(MembersSubscriptionLoaded(Map.from(_cachedSubscriptions)));
  }

  Future<void> addSubscription(MemberSubscriptionModel model) async {
    final updated = _recalculateSubscription(model);

    final result = await repo.addMemberSubscription(updated);

    result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (_) {
      // ⚡ حدث الـ cache فورًا
      _cachedSubscriptions[model.memberId] = updated;

      // ⚡ emit جديد لتحديث Table
      emit(MembersSubscriptionLoaded(Map.from(_cachedSubscriptions)));

      // ⚡ optional: success للDialog
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
      // ⚡ Extend
      updated = currentSub.copyWith(
        endDate: currentSub.endDate.add(Duration(days: plan.durationDays)),
        subscriptionId: plan.id,
        status: SubscriptionStatus.active,
        dateIdForReport: generateDateId(now),
        isRenewal: true,
      );
    }

    // ⚡ حساب remainingDays و status بعد التعديل
    final recalculated = _recalculateSubscription(updated);

    final result = await repo.updateMemberSubscription(recalculated);

    result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (_) {
      // ⚡ حدث الـ cache بعد نجاح العملية
      _cachedSubscriptions[currentSub.memberId] = recalculated;
      _emitCache();

      // ⚡ success emit للDialog أو أي listener
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
        }
      });
    }

    _emitCache();
  }

  Future<void> markAttendance({
    required MemberSubscriptionModel subscription,
  }) async {
    final plan = await getPlan(subscription.subscriptionId);
    if (plan == null) return;

    if (subscription.status != SubscriptionStatus.active) {
      emit(MemberSubscriptionFailure('الاشتراك غير نشط'));
      return;
    }

    final today = DateUtils.dateOnly(DateTime.now());
    final dateId = today.toIso8601String().split('T').first;

    if (subscription.dateIdAttendance == dateId) {
      emit(MemberSubscriptionFailure('تم تسجيل الحضور اليوم بالفعل'));
      return;
    }

    if (subscription.attendance >= plan.maxAttendance) {
      emit(MemberSubscriptionFailure('تم الوصول للحد الأقصى للحضور'));
      return;
    }

    final updated = subscription.copyWith(
      attendance: subscription.attendance + 1,
      dateIdAttendance: dateId,
    );

    final result = await repo.updateMemberSubscription(updated);

    result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (_) {
      _cachedSubscriptions[subscription.memberId] = updated;
      _emitCache();
      emit(
        MemberSubscriptionAttendanceSuccess(subscription: updated, plan: plan),
      );
    });
  }

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

    result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (_) {
      _cachedSubscriptions[subscription.memberId] = updated;
      _emitCache();
    });
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

  Future<void> useInvitation(MemberSubscriptionModel subscription) async {
    final updated = subscription.copyWith();

    final result = await repo.updateMemberSubscription(updated);

    result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (_) {
      _cachedSubscriptions[subscription.memberId] = updated;
      _emitCache();
    });
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
