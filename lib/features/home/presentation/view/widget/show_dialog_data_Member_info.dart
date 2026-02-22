import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/attendance_cubit.dart';
import 'package:power_gym/features/home/presentation/view/widget/GuestInvitationDialog.dart';
import 'package:power_gym/features/home/presentation/view/widget/elevated_boutton_member_info.dart';
import 'package:power_gym/features/home/presentation/view/widget/list_title_member_info.dart';
import 'package:power_gym/features/home/presentation/view/widget/text_boutton_member_info.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/model/show_dialog_data_member_Info_model.dart';

class ShowDialogDataMemberInfo extends StatelessWidget {
  const ShowDialogDataMemberInfo({super.key, required this.member});
  final MemberModel member;

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
                  trailing: member.name,
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'هاتف',
                  trailing: member.phone,
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'النوع',
                  trailing: member.gender,
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'تاريخ الانضمام',
                  trailing: '15/01/2023',
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'تاريخ النتهاء',
                  trailing: '15/01/2023',
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'خطة الاشتراكات',
                  trailing: '3 أشهر',
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'الحضور',
                  trailing: '120',
                ),
              ),

              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'دعوه',
                  trailing: '3',
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'تجميد',
                  trailing: '10',
                ),
              ),

              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'مدرب',
                  trailing: 'أحمد علي',
                ),
              ),
              ListTitleMemberInfo(
                showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                  title: 'ملحوظات',
                  trailing: '_',
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
                    member: member,
                  );
                },
                child: BlocBuilder<MemberSubscriptionCubit, MemberSubscriptionState>(
                  builder: (context, state) {
                    final cubit = context.watch<MemberSubscriptionCubit>();
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
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }
                    final remainingInvitations =
                        subscription.totalInvitations -
                        subscription.usedInvitations;

                    final canAttend =
                        subscription.status == SubscriptionStatus.active &&
                        subscription.attendance < plan.maxAttendance;

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (plan.type == 'pt')
                          ElevatedBouttonMemberInfo(
                            text: 'حضور PT',
                            onPressed: canAttend
                                ? () {
                                    context
                                        .read<MemberSubscriptionCubit>()
                                        .markAttendance(
                                          subscription: subscription,
                                        );
                                  }
                                : null,
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
                                    member: member,
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

                        TextBouttonMemberInfo(
                          text: 'تجميد',
                          onPressed:
                              subscription.status ==
                                      SubscriptionStatus.active &&
                                  plan.freezeDays > 0
                              ? () async {
                                  final TextEditingController daysController =
                                      TextEditingController(
                                        text: plan.freezeDays.toString(),
                                      );

                                  // فتح Dialog لاختيار عدد الأيام
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
                                              'الحد الأقصى المسموح: ${plan.freezeDays} أيام',
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
