import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/helper/format_date_helper.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/attendance_cubit.dart';
import 'package:power_gym/features/home/presentation/view/widget/GuestInvitationDialog.dart';
import 'package:power_gym/features/home/presentation/view/widget/elevated_boutton_member_info.dart';
import 'package:power_gym/features/home/presentation/view/widget/list_title_member_info.dart';
import 'package:power_gym/features/home/presentation/view/widget/text_boutton_member_info.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/peivate/presentation/manger/cubit/private_cubit.dart';
import 'package:power_gym/model/show_dialog_data_member_Info_model.dart';

class ShowDialogDataMemberInfo extends StatefulWidget {
  const ShowDialogDataMemberInfo({
    super.key,
    required this.member,
    required this.subscription,
  });
  final MemberModel member;
  final MemberSubscriptionModel subscription;

  @override
  State<ShowDialogDataMemberInfo> createState() =>
      _ShowDialogDataMemberInfoState();
}

class _ShowDialogDataMemberInfoState extends State<ShowDialogDataMemberInfo> {
  @override
  void initState() {
    super.initState();
    context.read<PrivateCubit>().loadPrivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kprimaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('معلومات العضو', style: AppStyle.style20W500),
              SizedBox(height: 20),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'اسم',
                  trailing: widget.member.name,
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'هاتف',
                  trailing: widget.member.phone,
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'النوع',
                  trailing: widget.member.gender,
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'تاريخ البدايه',
                  trailing: FormatDateHelper.formatDate(
                    widget.subscription.startDate.toString(),
                  ),
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'تاريخ النتهاء',
                  trailing: FormatDateHelper.formatDate(
                    widget.subscription.endDate.toString(),
                  ),
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'الحضور',
                  trailing: '${widget.subscription.attendance}',
                ),
              ),

              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'دعوه',
                  trailing:
                      '${widget.subscription.usedInvitations} / ${widget.subscription.totalInvitations}',
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'تجميد',
                  trailing: '${widget.subscription.freeze} أيام',
                ),
              ),

              BlocListener<MemberSubscriptionCubit, MemberSubscriptionState>(
                listenWhen: (_, curr) =>
                    curr is MemberSubscriptionAttendanceSuccess,
                listener: (context, state) {
                  final s = state as MemberSubscriptionAttendanceSuccess;

                  context.read<AttendanceCubit>().markPresent(
                    subscription: s.subscription,
                    plan: s.plan,
                    member: widget.member,
                  );
                },
                child: BlocBuilder<MemberSubscriptionCubit, MemberSubscriptionState>(
                  builder: (context, state) {
                    final cubit = context.watch<MemberSubscriptionCubit>();
                    final subscription =
                        cubit.cachedSubscriptions[widget.member.id];

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
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }
                    final remainingInvitations =
                        subscription.totalInvitations -
                        subscription.usedInvitations;

                    final canAttend =
                        subscription.status == SubscriptionStatus.active &&
                        subscription.attendance < subscription.maxAttendance;

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocBuilder<PrivateCubit, PrivateState>(
                          builder: (context, privateState) {
                            if (privateState is PrivateLoaded) {
                              final hasActivePrivate = privateState.private.any(
                                (plan) =>
                                    plan.member.id == widget.member.id &&
                                    plan.status == PrivateStatus.active,
                              );

                              if (!hasActivePrivate) {
                                return const SizedBox();
                              }

                              return ElevatedBouttonMemberInfo(
                                text: 'حصة Pt',
                                onPressed: () async {
                                  final privateCubit = context
                                      .read<PrivateCubit>();
                                  final subscriptionCubit = context
                                      .read<MemberSubscriptionCubit>();
                                  final attendanceCubit = context
                                      .read<AttendanceCubit>();

                                  final privatePlan = privateState.private
                                      .firstWhere(
                                        (plan) =>
                                            plan.member.id ==
                                                widget.member.id &&
                                            plan.status == PrivateStatus.active,
                                      );

                                  await privateCubit.takePrivateAttendance(
                                    privatePlan,
                                  );

                                  final result = await subscriptionCubit
                                      .markAttendance(
                                        subscription: subscription,
                                      );

                                  attendanceCubit.markPresent(
                                    subscription: subscription,
                                    plan: plan,
                                    member: widget.member,
                                  );

                                  result.fold(
                                    (error) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('حدث خطأ: $error'),
                                        ),
                                      );
                                    },
                                    (_) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'تم تسجيل حضور pt + عادي',
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }

                            return const SizedBox();
                          },
                        ),

                        ElevatedBouttonMemberInfo(
                          text: 'يقبل',
                          onPressed: canAttend
                              ? () async {
                                  final cubit = context
                                      .read<MemberSubscriptionCubit>();

                                  final result = await cubit.markAttendance(
                                    subscription: subscription,
                                  );
                                  context.read<AttendanceCubit>().markPresent(
                                    subscription: subscription,
                                    plan: plan,
                                    member: widget.member,
                                  );

                                  result.fold(
                                    (error) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('حدث خطأ: $error'),
                                        ),
                                      );
                                    },
                                    (_) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'تم تسجيل الحضور بنجاح',
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              : null,
                        ),

                        ElevatedBouttonMemberInfo(
                          text: 'تجميد',
                          onPressed:
                              subscription.status ==
                                      SubscriptionStatus.active &&
                                  subscription.freeze > 0
                              ? () async {
                                  final TextEditingController daysController =
                                      TextEditingController(
                                        text: subscription.freeze.toString(),
                                      );

                                  final int? chosenDays = await showDialog<int>(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Text(
                                          'اختر عدد أيام التجميد',
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'الحد الأقصى المسموح: ${subscription.freeze} أيام',
                                            ),
                                            const SizedBox(height: 10),
                                            TextField(
                                              controller: daysController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                labelText: 'عدد الأيام',
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(ctx).pop(null),
                                            child: const Text('إلغاء'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              final input = int.tryParse(
                                                daysController.text.trim(),
                                              );
                                              if (input == null ||
                                                  input < 1 ||
                                                  input > plan.freezeDays) {
                                                ScaffoldMessenger.of(
                                                  ctx,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'من فضلك أدخل قيمة بين 1 و ${plan.freezeDays}',
                                                    ),
                                                  ),
                                                );
                                                return;
                                              }

                                              Navigator.of(ctx).pop(input);
                                            },
                                            child: const Text('تأكيد'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (chosenDays != null) {
                                    final cubit = context
                                        .read<MemberSubscriptionCubit>();

                                    final result = await cubit.applyFreeze(
                                      subscription: subscription,
                                      freezeDays: chosenDays,
                                    );

                                    result.fold(
                                      (error) => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                            SnackBar(
                                              content: Text('حدث خطأ: $error'),
                                            ),
                                          ),
                                      (_) => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'تم تجميد الاشتراك بنجاح',
                                              ),
                                            ),
                                          ),
                                    );
                                  }
                                }
                              : null,
                        ),

                        TextBouttonMemberInfo(
                          text: 'دعوة مرافق ($remainingInvitations)',
                          onPressed:
                              remainingInvitations > 0 &&
                                  subscription.status ==
                                      SubscriptionStatus.active
                              ? () async {
                                  final result = await showDialog(
                                    context: context,
                                    builder: (_) => GuestInvitationDialog(
                                      subscription: subscription,
                                      member: widget.member,
                                    ),
                                  );

                                  if (result == null)
                                    return; // المستخدم ضغط إلغاء

                                  // 2️⃣ استدعاء Cubit method
                                  final cubit = context
                                      .read<MemberSubscriptionCubit>();
                                  final invitationResult = await cubit
                                      .useInvitation(
                                        subscription: subscription,
                                        guestName: result.name,
                                        guestPhone: result.phone,
                                        member: widget.member,
                                      );

                                  // 3️⃣ عرض Feedback
                                  invitationResult.fold(
                                    (error) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text('حدث خطأ: $error'),
                                        ),
                                      );
                                    },
                                    (_) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'تم تسجيل الدعوة بنجاح',
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              : null,
                        ),
                        ElevatedBouttonMemberInfo(
                          text: widget.member.note == null
                              ? 'تسجيل ملاحظة'
                              : 'تعديل ملاحظة',
                          onPressed: () async {
                            final controller = TextEditingController(
                              text: widget.member.note ?? '',
                            );

                            final result = await showDialog<String>(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: Text(
                                    widget.member.note == null
                                        ? 'إضافة ملاحظة'
                                        : 'تعديل الملاحظة',
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (widget.member.noteCreatedAt != null)
                                        Text(
                                          'تاريخ الحفظ: '
                                          '${FormatDateHelper.formatDate(widget.member.noteCreatedAt.toString())}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: controller,
                                        maxLines: 3,
                                        decoration: const InputDecoration(
                                          hintText: 'اكتب الملاحظة هنا',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    if (widget.member.note != null)
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, 'delete'),
                                        child: const Text(
                                          'حذف',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text('إلغاء'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          ctx,
                                          controller.text.trim(),
                                        );
                                      },
                                      child: const Text('حفظ'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (result == null) return;

                            final cubit = context.read<MembersCubit>();

                            if (result == 'delete') {
                              await cubit.deleteNote(widget.member.id);
                            } else {
                              await cubit.addOrUpdateNote(
                                widget.member.id,
                                result,
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
