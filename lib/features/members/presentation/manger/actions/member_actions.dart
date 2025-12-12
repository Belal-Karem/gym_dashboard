import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/helper/date_helper.dart';
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
  }) async {
    final membersCubit = context.read<MembersCubit>();
    final subscriptionsCubit = context.read<SubscriptionsCubit>();

    String? memberIdToReturn;

    try {
      // عرض Loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final result = await membersCubit.addMemberAndReturnId(member);

      await result.fold(
        (failure) {
          Navigator.pop(context); // غلق الـ dialog
          Navigator.pop(context);
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(failure.message)));
        },
        (memberId) async {
          memberIdToReturn = memberId;

          // حساب تاريخ الانتهاء وعدد الأيام المتبقية
          final endDate = DateHelper.calculateEndDate(
            member.startdata,
            selectedSub.duration,
          );
          final remainingDays = DateHelper.calculateDaysRemaining(endDate);

          // تحديث العضو في القاعدة
          await membersCubit.updateMember(memberId, {
            'endDate': endDate,
            'remainingDays': remainingDays.toString(),
          });

          // إنشاء الاشتراك
          final sub = MemberSubscriptionModel(
            memberId: memberId,
            subId: selectedSub.id,
            startDate: member.startdata,
            endDate: endDate,
            status: "active",
            remainingDays: remainingDays,
          );

          await subscriptionsCubit.addSubscription(sub);

          Navigator.pop(context); // غلق الـ dialog
          Navigator.pop(context);
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('تم الحفظ بنجاح')));

          membersCubit.loadMembers();
        },
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ غير متوقع: $e')));
    }

    return memberIdToReturn;
  }
}
