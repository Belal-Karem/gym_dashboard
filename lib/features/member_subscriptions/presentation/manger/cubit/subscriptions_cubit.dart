import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_with_plan_model.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/member_subscriptions_repo.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/plans_repo.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

part 'subscriptions_state.dart';

// class MemberSubscriptionCubit extends Cubit<MemberSubscriptionState> {
//   final MemberSubscriptionsRepo repo;
//   final PlansRepo plansRepo;

//   MemberSubscriptionCubit(this.repo, this.plansRepo)
//     : super(MemberSubscriptionInitial());

//   /// إضافة اشتراك جديد
//   Future<void> addSubscription(MemberSubscriptionModel model) async {
//     emit(MemberSubscriptionLoading());

//     final updatedModel = _recalculateSubscription(model);

//     final result = await repo.addMemberSubscription(updatedModel);

//     result.fold(
//       (failure) => emit(MemberSubscriptionFailure(failure.message)),
//       (_) => emit(MemberSubscriptionAddSuccess()),
//     );
//   }

//   /// جلب اشتراك العضو الحالي
//   Future<void> getMemberSubscriptions(String memberId) async {
//     emit(MemberSubscriptionLoading());

//     final result = await repo.getSubscriptionsByMember(memberId);

//     result.fold((failure) => emit(MemberSubscriptionFailure(failure.message)), (
//       list,
//     ) async {
//       if (list.isEmpty) {
//         emit(MemberSubscriptionEmpty());
//         return;
//       }

//       final recalculated = list.map(_recalculateSubscription).toList();

//       final validSubs = recalculated
//           .where(
//             (s) =>
//                 s.status == SubscriptionStatus.active ||
//                 s.status == SubscriptionStatus.frozen,
//           )
//           .toList();

//       if (validSubs.isEmpty) {
//         emit(MemberSubscriptionEmpty());
//         return;
//       }

//       final activeSub = validSubs.first;

//       final planResult = await plansRepo.getPlanById(activeSub.subscriptionId);

//       planResult.fold(
//         (failure) => emit(MemberSubscriptionFailure(failure.message)),
//         (plan) =>
//             emit(MemberSubscriptionLoaded(subscription: activeSub, plan: plan)),
//       );
//     });
//   }

//   /// تجديد الاشتراك
//   Future<void> renewSubscription(
//     MemberSubscriptionModel oldSub,
//     SubModel newPlan,
//   ) async {
//     emit(MemberSubscriptionLoading());

//     final startDate = oldSub.endDate.isAfter(DateTime.now())
//         ? oldSub.endDate
//         : DateTime.now();
//     final endDate = startDate.add(Duration(days: newPlan.durationDays));

//     final renewed = oldSub.copyWith(
//       startDate: startDate,
//       endDate: endDate,
//       remainingDays: endDate.difference(startDate).inDays,
//       attendance: 0,
//     );

//     final result = await repo.updateMemberSubscription(renewed);

//     result.fold(
//       (failure) => emit(MemberSubscriptionFailure(failure.message)),
//       (_) => emit(MemberSubscriptionUpdateSuccess()),
//     );
//   }

//   /// تطبيق فريز
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

//     result.fold((failure) => emit(MemberSubscriptionFailure(failure.message)), (
//       _,
//     ) async {
//       await getMemberSubscriptions(subscription.memberId);
//     });
//   }

//   /// تسجيل حضور
//   Future<void> markAttendance({
//     required MemberSubscriptionModel subscription,
//     required SubModel plan,
//   }) async {
//     final today = DateUtils.dateOnly(DateTime.now());
//     final dateIdAttendance = today.toIso8601String().split('T').first;

//     // تحقق من الاشتراك
//     if (subscription.status != SubscriptionStatus.active) {
//       emit(MemberSubscriptionFailure('الاشتراك غير نشط'));
//       return;
//     }

//     if (subscription.dateIdAttendance == dateIdAttendance) {
//       emit(MemberSubscriptionFailure('تم تسجيل الحضور بالفعل اليوم'));
//       return;
//     }

//     if (subscription.attendance >= plan.maxAttendance) {
//       emit(MemberSubscriptionFailure('تم الوصول للحد الأقصى للحضور'));
//       return;
//     }

//     emit(MemberSubscriptionLoading());

//     final updated = subscription.copyWith(
//       attendance: subscription.attendance + 1,
//       dateIdAttendance: dateIdAttendance,
//     );

//     final result = await repo.updateMemberSubscription(updated);

//     result.fold((failure) => emit(MemberSubscriptionFailure(failure.message)), (
//       _,
//     ) async {
//       await getMemberSubscriptions(subscription.memberId);
//       emit(
//         MemberSubscriptionAttendanceSuccess(subscription: updated, plan: plan),
//       );
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

//   /// استخدام دعوة
//   Future<void> useInvitation(MemberSubscriptionModel subscription) async {
//     final updated = subscription.copyWith(
//       // logic الخصم أو العد
//     );

//     final result = await repo.updateMemberSubscription(updated);

//     result.fold((failure) => emit(MemberSubscriptionFailure(failure.message)), (
//       _,
//     ) async {
//       await getMemberSubscriptions(subscription.memberId);
//     });
//   }

//   /// تحميل الاشتراكات لكل الأعضاء (نشطة + مجمدة)
//   Future<void> loadMembersActiveSubscriptions(List<MemberModel> members) async {
//     emit(MemberSubscriptionLoading());

//     final Map<String, MemberSubscriptionModel> result = {};

//     for (final member in members) {
//       final response = await repo.getSubscriptionsByMember(member.id); // ✅

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
//           result[member.id] = valid.first; // ✅ نفس المفتاح
//         }
//       });
//     }

//     emit(MembersSubscriptionLoaded(result));
//   }
// }

class MemberSubscriptionCubit extends Cubit<MemberSubscriptionState> {
  final MemberSubscriptionsRepo repo;
  final PlansRepo plansRepo;

  final Map<String, MemberSubscriptionModel> _cachedSubscriptions = {};
  final Map<String, SubModel> _plansCache = {};

  MemberSubscriptionCubit(this.repo, this.plansRepo)
    : super(MemberSubscriptionInitial());

  /* ================= CACHE EMIT ================= */

  void _emitCache() {
    emit(MembersSubscriptionLoaded(Map.from(_cachedSubscriptions)));
  }

  /* ================= ADD SUB ================= */

  Future<void> addSubscription(MemberSubscriptionModel model) async {
    final updated = _recalculateSubscription(model);

    final result = await repo.addMemberSubscription(updated);

    result.fold(
      (f) => emit(MemberSubscriptionFailure(f.message)),
      (_) => emit(MemberSubscriptionAddSuccess()),
    );
  }

  /* ================= GET MEMBER SUB ================= */

  Future<void> getMemberSubscriptions(String memberId) async {
    final result = await repo.getSubscriptionsByMember(memberId);

    result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (list) {
      final valid = list
          .map(_recalculateSubscription)
          .where(
            (s) =>
                s.status == SubscriptionStatus.active ||
                s.status == SubscriptionStatus.frozen,
          )
          .toList();

      if (valid.isEmpty) {
        _cachedSubscriptions.remove(memberId);
      } else {
        _cachedSubscriptions[memberId] = valid.first;
      }

      _emitCache();
    });
  }

  /* ================= MARK ATTENDANCE ================= */

  Future<void> markAttendance({
    required MemberSubscriptionModel subscription,
  }) async {
    final plan = await getPlan(subscription.subscriptionId);
    if (plan == null) return;

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

  /* ================= FREEZE ================= */

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

  /* ================= INVITATION ================= */

  Future<void> useInvitation(MemberSubscriptionModel subscription) async {
    final updated = subscription.copyWith(
      // TODO: invitation logic
    );

    final result = await repo.updateMemberSubscription(updated);

    result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (_) {
      _cachedSubscriptions[subscription.memberId] = updated;
      _emitCache();
    });
  }

  /* ================= LOAD ALL MEMBERS ================= */

  Future<void> loadMembersActiveSubscriptions(List<MemberModel> members) async {
    for (final member in members) {
      final response = await repo.getSubscriptionsByMember(member.id);

      response.fold((_) {}, (subs) {
        final valid = subs
            .map(_recalculateSubscription)
            .where(
              (s) =>
                  s.status == SubscriptionStatus.active ||
                  s.status == SubscriptionStatus.frozen,
            )
            .toList();

        if (valid.isNotEmpty) {
          _cachedSubscriptions[member.id] = valid.first;
        }
      });
    }

    _emitCache();
  }

  /* ================= PLAN CACHE ================= */

  SubModel? getPlan(String planId) {
    if (_plansCache.containsKey(planId)) {
      return _plansCache[planId];
    }

    // 👇 تحميل في الخلفية من غير ما نكسر الـ UI
    _loadPlan(planId);
    return null;
  }

  Future<void> _loadPlan(String planId) async {
    if (_plansCache.containsKey(planId)) return;

    final result = await plansRepo.getPlanById(planId);

    result.fold((f) => emit(MemberSubscriptionFailure(f.message)), (plan) {
      _plansCache[planId] = plan;

      // 👇 نعيد نفس الـ state عشان UI يعمل rebuild
      emit(MembersSubscriptionLoaded(Map.from(_cachedSubscriptions)));
    });
  }

  /* ================= HELPERS ================= */

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
