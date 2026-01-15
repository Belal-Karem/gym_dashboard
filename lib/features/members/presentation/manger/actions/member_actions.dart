import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

class MemberActions {
  static Future<String?> saveMemberAndSubscription({
    required BuildContext context,
    required MemberModel member,
    required SubModel selectedSub,
    required DateTime startDate,
  }) async {
    final membersCubit = context.read<MembersCubit>();
    final subscriptionsCubit = context.read<MemberSubscriptionCubit>();

    String? memberIdToReturn;

    try {
      // ✅ Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // ✅ Add member and get ID
      final result = await membersCubit.addMemberAndReturnId(member);

      await result.fold(
        (failure) {
          Navigator.pop(context); // Close loading
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(failure.message)));
        },
        (memberId) async {
          memberIdToReturn = memberId;

          // ✅ Calculate subscription details
          final endDate = startDate.add(
            Duration(days: selectedSub.durationDays),
          );
          final remainingDays = endDate.difference(DateTime.now()).inDays;
          final status = remainingDays <= 0
              ? SubscriptionStatus.expired
              : SubscriptionStatus.active;

          // ✅ Create dateId for payments tracking
          final dateId = DateFormat('yyyy-MM-dd').format(DateTime.now());

          // ✅ Create member subscription
          final memberSub = MemberSubscriptionModel(
            id: '',
            memberId: memberId,
            subscriptionId: selectedSub.id,
            startDate: startDate,
            endDate: endDate,
            remainingDays: remainingDays,
            attendance: 0,
            status: status,
            dateId: dateId,
          );

          // ✅ Save subscription
          await subscriptionsCubit.addSubscription(memberSub);

          Navigator.pop(context); // Close loading

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم الحفظ بنجاح'),
              backgroundColor: Colors.green,
            ),
          );

          // ✅ Reload members list
          membersCubit.loadMembers();
        },
      );
    } catch (e) {
      Navigator.pop(context); // Close loading if open
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ غير متوقع: $e')));
    }

    return memberIdToReturn;
  }
}
