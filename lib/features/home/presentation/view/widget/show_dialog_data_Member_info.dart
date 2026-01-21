import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/attendance_cubit.dart';
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
                child:
                    BlocBuilder<
                      MemberSubscriptionCubit,
                      MemberSubscriptionState
                    >(
                      builder: (context, state) {
                        final cubit = context.watch<MemberSubscriptionCubit>();
                        final subscription =
                            cubit.cachedSubscriptions[member.id];

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
                                  ? () {
                                      context
                                          .read<MemberSubscriptionCubit>()
                                          .markAttendance(
                                            subscription: subscription,
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
                                      // افتح Dialog للاختيار
                                      final int?
                                      chosenDays = await showDialog<int>(
                                        context: context,
                                        builder: (ctx) {
                                          int selectedDays = plan
                                              .freezeDays; // القيمة الافتراضية

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
                                                SizedBox(height: 10),
                                                // Slider للاختيار
                                                StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return Slider(
                                                      value: selectedDays
                                                          .toDouble(),
                                                      min: 1,
                                                      max: plan.freezeDays
                                                          .toDouble(),
                                                      divisions:
                                                          plan.freezeDays,
                                                      label:
                                                          '$selectedDays يوم',
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedDays = value
                                                              .toInt();
                                                        });
                                                      },
                                                    );
                                                  },
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
                                                onPressed: () => Navigator.of(
                                                  ctx,
                                                ).pop(selectedDays),
                                                child: const Text('تأكيد'),
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      // لو المستخدم اختار أيام
                                      if (chosenDays != null) {
                                        context
                                            .read<MemberSubscriptionCubit>()
                                            .applyFreeze(
                                              subscription: subscription,
                                              freezeDays: chosenDays,
                                            );
                                      }
                                    }
                                  : null,
                            ),

                            TextBouttonMemberInfo(
                              text: 'دعوه',
                              onPressed: plan.invitationCount > 0
                                  ? () {
                                      context
                                          .read<MemberSubscriptionCubit>()
                                          .useInvitation(subscription);
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
