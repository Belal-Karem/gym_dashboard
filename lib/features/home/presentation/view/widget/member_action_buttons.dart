import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/attendance_cubit.dart';
import 'package:power_gym/features/home/presentation/view/widget/elevated_boutton_member_info.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/peivate/data/models/private_model/private_model.dart';
import 'package:power_gym/features/peivate/presentation/manger/cubit/private_cubit.dart';

import '../../../../../core/helper/build_error_bar.dart';
import '../../../../../core/helper/show_message.dart';
import '../../../../../core/widget/app_loading_widget.dart';
import '../../../../members/presentation/manger/cubit/member_cubit.dart';
import 'GuestInvitationDialog.dart';
import 'text_boutton_member_info.dart';

class MemberActionButtons extends StatelessWidget {
  const MemberActionButtons({required this.member});

  final MemberModel member;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberSubscriptionCubit, MemberSubscriptionState>(
      buildWhen: (_, curr) =>
          curr is MemberSubscriptionAttendanceSuccess ||
          curr is MemberSubscriptionInitial,
      builder: (context, state) {
        final cubit = context.read<MemberSubscriptionCubit>();
        final subscription = cubit.cachedSubscriptions[member.id];

        if (subscription == null) {
          return const Text(
            'لا يوجد اشتراك نشط',
            style: TextStyle(color: Colors.red),
          );
        }

        final plan = cubit.getPlan(subscription.subscriptionId);

        if (plan == null) {
          return const SizedBox(
            width: 24,
            height: 24,
            child: AppLoadingWidget(),
          );
        }

        final remainingInvitations =
            subscription.totalInvitations - subscription.usedInvitations;

        final canAttend =
            subscription.status == SubscriptionStatus.active &&
            subscription.attendance < subscription.maxAttendance;

        return Wrap(
          children: [
            BlocBuilder<PrivateCubit, PrivateState>(
              builder: (context, privateState) {
                if (privateState is PrivateLoading) {
                  return AppLoadingWidget();
                }

                if (privateState is PrivateError) {
                  return const SizedBox();
                }

                if (privateState is PrivateLoaded) {
                  final hasActivePrivate = privateState.private.any(
                    (plan) =>
                        plan.member.id == member.id &&
                        plan.status == PrivateStatus.active,
                  );

                  if (!hasActivePrivate) return const SizedBox();

                  final privatePlan = privateState.private.firstWhere(
                    (plan) =>
                        plan.member.id == member.id &&
                        plan.status == PrivateStatus.active,
                  );

                  return privateAttendance(context, privatePlan);
                }

                return const SizedBox();
              },
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _acceptButton(context, subscription, canAttend),
                _freezeButton(context, subscription, plan),
                _invitationButton(context, subscription, remainingInvitations),
                _noteButton(context),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget privateAttendance(BuildContext context, PrivateModel privatePlan) {
    return ElevatedBouttonMemberInfo(
      text: 'حصة PT',
      onPressed: () async {
        final privateCubit = context.read<PrivateCubit>();
        final subscriptionCubit = context.read<MemberSubscriptionCubit>();
        final attendanceCubit = context.read<AttendanceCubit>();

        await privateCubit.takePrivateAttendance(privatePlan);

        final subscription = subscriptionCubit.cachedSubscriptions[member.id];

        // final plan = subscriptionCubit.getPlan(subscription!.subscriptionId);

        final result = await subscriptionCubit.markAttendance(
          subscription: subscription!,
        );

        attendanceCubit.markPresent(subscription: subscription, member: member);

        handleResult(context, result, 'تم تسجيل حضور pt + عادي');
      },
    );
  }

  Widget _acceptButton(
    BuildContext context,
    MemberSubscriptionModel subscription,
    bool canAttend,
  ) {
    return ElevatedBouttonMemberInfo(
      text: 'يقبل',
      onPressed: canAttend
          ? () async {
              final cubit = context.read<MemberSubscriptionCubit>();

              final result = await cubit.markAttendance(
                subscription: subscription,
              );

              context.read<AttendanceCubit>().markPresent(
                subscription: subscription,
                member: member,
              );

              handleResult(context, result, 'تم تسجيل الحضور بنجاح');
            }
          : null,
    );
  }

  Widget _freezeButton(
    BuildContext context,
    MemberSubscriptionModel subscription,
    dynamic plan,
  ) {
    return ElevatedBouttonMemberInfo(
      text: 'تجميد',
      onPressed:
          subscription.status == SubscriptionStatus.active &&
              subscription.freeze > 0
          ? () async {
              final days = await _showFreezeDialog(context, plan.freezeDays);

              if (days == null) return;

              final result = await context
                  .read<MemberSubscriptionCubit>()
                  .applyFreeze(subscription: subscription, freezeDays: days);

              handleResult(context, result, 'تم تجميد الاشتراك بنجاح');
            }
          : null,
    );
  }

  Widget _invitationButton(
    BuildContext context,
    MemberSubscriptionModel subscription,
    int remainingInvitations,
  ) {
    return TextBouttonMemberInfo(
      text: 'دعوة مرافق ($remainingInvitations)',
      onPressed:
          remainingInvitations > 0 &&
              subscription.status == SubscriptionStatus.active
          ? () async {
              final result = await showDialog(
                context: context,
                builder: (_) => GuestInvitationDialog(
                  subscription: subscription,
                  member: member,
                ),
              );

              if (result == null) return;

              final invitationResult = await context
                  .read<MemberSubscriptionCubit>()
                  .useInvitation(
                    subscription: subscription,
                    guestName: result.name,
                    guestPhone: result.phone,
                    member: member,
                  );

              handleResult(context, invitationResult, 'تم تسجيل الدعوة بنجاح');
            }
          : null,
    );
  }

  Widget _noteButton(BuildContext context) {
    return ElevatedBouttonMemberInfo(
      text: member.note == null ? 'تسجيل ملاحظة' : 'تعديل ملاحظة',
      onPressed: () async {
        final result = await _showNoteDialog(context);

        if (result == null) return;

        final cubit = context.read<MembersCubit>();

        if (result == 'delete') {
          await cubit.deleteNote(member.id);
        } else {
          await cubit.addOrUpdateNote(member.id, result);
        }
      },
    );
  }

  Future<int?> _showFreezeDialog(BuildContext context, int maxDays) async {
    final controller = TextEditingController(text: maxDays.toString());

    return showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('اختر عدد أيام التجميد'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              final input = int.tryParse(controller.text.trim());
              if (input == null || input < 1 || input > maxDays) {
                buildErrorBar(context, 'من فضلك أدخل قيمة بين 1 و $maxDays');
                return;
              }
              Navigator.pop(ctx, input);
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  Future<String?> _showNoteDialog(BuildContext context) {
    final controller = TextEditingController(text: member.note ?? '');

    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(member.note == null ? 'إضافة ملاحظة' : 'تعديل الملاحظة'),
        content: TextField(controller: controller, maxLines: 3),
        actions: [
          if (member.note != null)
            TextButton(
              onPressed: () => Navigator.pop(ctx, 'delete'),
              child: const Text('حذف', style: TextStyle(color: Colors.red)),
            ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }
}
