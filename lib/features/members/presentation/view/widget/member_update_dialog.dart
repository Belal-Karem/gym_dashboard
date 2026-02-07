import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/helper/format_date_helper.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/utils/date_utils.dart';
import 'package:power_gym/core/widget/custom_dropdown_widget.dart';
import 'package:power_gym/core/widget/double_field_row_add_widget.dart';
import 'package:power_gym/core/widget/field_label_and_input_add_widget.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/view/select_sup_view.dart';
import 'package:power_gym/features/plan_and_packages/presentation/view/widget/dialog_add_plan.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

class MemberDialog extends StatefulWidget {
  final MemberModel member;
  final MemberSubscriptionModel subscription;
  final List<MemberSubscriptionModel> history;

  const MemberDialog({
    super.key,
    required this.member,
    required this.subscription,
    this.history = const [],
  });

  @override
  State<MemberDialog> createState() => _MemberDialogState();
}

class _MemberDialogState extends State<MemberDialog> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late DateTime affiliationdate;
  String? selectedStatus;
  String? selectedGender;
  late DateTime endDate;
  late DateTime startDate;
  late int remainingDays;
  late int freeze;
  late int totalInvitations;
  late int usedInvitations;
  final starDateForAdd = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.member.name);
    phoneController = TextEditingController(text: widget.member.phone);
    affiliationdate = widget.member.affiliationDate;
    selectedGender = widget.member.gender;
    endDate = widget.subscription.endDate;
    startDate = widget.subscription.startDate;
    remainingDays = widget.subscription.remainingDays;
    freeze = widget.subscription.freeze;
    totalInvitations = widget.subscription.totalInvitations;
    usedInvitations = widget.subscription.usedInvitations;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
    starDateForAdd.text = DateFormat(
      'yyyy-MM-dd',
      'en_US',
    ).format(DateTime.now());
  }

  void updateMember() {
    final updatedMember = widget.member.copyWith(
      name: nameController.text,
      phone: phoneController.text,
      gender: selectedGender ?? widget.member.gender,
    );

    BlocProvider.of<MembersCubit>(
      context,
    ).updateMember(updatedMember.id, updatedMember.toJson());
    Navigator.pop(context);
  }

  void deleteMember() {
    BlocProvider.of<MembersCubit>(context).deleteMember(widget.member.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print('=============== ${widget.subscription}');
    return Dialog(
      backgroundColor: kprimaryColor,
      child: SingleChildScrollView(
        child: SizedBox(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 400,
                          child: SubscriptionsMeberList(
                            history: widget.history,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          ' بيانات العضو',
                          style: AppStyle.style20W500,
                        ),
                        DisplayData(
                          label: 'تاريخ الانضمام',
                          child: affiliationdate.toString(),
                        ),
                        DisplayData(
                          label: 'تاريخ البدء',
                          child: startDate.toString(),
                        ),
                        DisplayData(
                          label: 'تاريخ النتهاء',
                          child: endDate.toString(),
                        ),

                        DisplayData(
                          label: 'الايام المتبقيه',
                          child2: remainingDays.toString(),
                        ),
                        DisplayData(
                          label: 'التجميد',
                          child2: freeze.toString(),
                        ),
                        DisplayData(
                          label: 'الدعوات',
                          child2: '$usedInvitations / $totalInvitations',
                        ),

                        const Text('تعديل', style: AppStyle.style20W500),
                        FieldLabelAndInputAddWidget(
                          label: 'الاسم',
                          child: TextFieldAddWidget(controller: nameController),
                        ),
                        FieldLabelAndInputAddWidget(
                          label: 'الهاتف',
                          child: TextFieldAddWidget(
                            controller: phoneController,
                          ),
                        ),

                        DoubleFieldRowAddWidget(
                          leftLabel: ' الحالة',
                          leftChild: CustomDropdownWidget(
                            items: const [
                              DropdownMenuItem(
                                value: 'نشط',
                                child: Text('نشط'),
                              ),
                              DropdownMenuItem(
                                value: 'متوقف',
                                child: Text('متوقف'),
                              ),
                              DropdownMenuItem(
                                value: 'توقف مؤقت',
                                child: Text('توقف مؤقت'),
                              ),
                            ],
                            initialValue: selectedStatus,
                            onChanged: (value) {
                              setState(() => selectedStatus = value);
                            },
                          ),
                          rightLabel: 'النوع',
                          rightChild: CustomDropdownWidget(
                            items: const [
                              DropdownMenuItem(
                                value: 'ذكر',
                                child: Text('ذكر'),
                              ),
                              DropdownMenuItem(
                                value: 'أنثى',
                                child: Text('أنثى'),
                              ),
                              DropdownMenuItem(
                                value: 'طفل',
                                child: Text('طفل'),
                              ),
                            ],
                            initialValue: selectedGender,
                            onChanged: (value) {
                              setState(() => selectedGender = value);
                            },
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                openAddPlanDialog(
                                  context,
                                  widget.member,
                                ); // ✅ نبعت العضو
                              },
                              child: const Text(
                                'اشتراك بريفت',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                final cubit = context
                                    .read<MemberSubscriptionCubit>();

                                // 📅 اختيار تاريخ البداية
                                final DateTime? startDate =
                                    await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2100),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.dark(
                                              primary: Color(0xff9D1D1E),
                                              onPrimary: Colors.white,
                                              surface: Color(0xff1D1E22),
                                              onSurface: Colors.white,
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );

                                if (startDate == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'يرجى اختيار تاريخ البداية',
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                Navigator.pop(context);

                                final selectedSub =
                                    await Navigator.push<SubModel>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SelectSupView(),
                                      ),
                                    );

                                if (selectedSub == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('يرجى اختيار مدة الاشتراك'),
                                    ),
                                  );
                                  return;
                                }

                                final endDate = startDate.add(
                                  Duration(days: selectedSub.durationDays),
                                );

                                final now = DateTime.now();

                                if (widget
                                    .subscription
                                    .subscriptionId
                                    .isEmpty) {
                                  cubit.addSubscription(
                                    MemberSubscriptionModel(
                                      id: '',
                                      memberId: widget.subscription.memberId,
                                      subscriptionId: selectedSub.id,
                                      startDate: startDate,
                                      endDate: endDate,
                                      actionDate: now,
                                      isRenewal: true,
                                      remainingDays: selectedSub.durationDays,
                                      attendance: 0,
                                      dateId: generateDateId(now),
                                      status: SubscriptionStatus.active,
                                      dateIdForReport: generateDateId(now),
                                      freezeEndDate: now,
                                      totalInvitations:
                                          selectedSub.invitationCount,
                                      usedInvitations: 0,
                                      freeze: selectedSub.freezeDays,
                                      maxAttendance: selectedSub.maxAttendance,
                                    ),
                                  );
                                } else {
                                  cubit.renewOrExtendSubscription(
                                    currentSub: widget.subscription,
                                    plan: selectedSub,
                                  );
                                }
                              },

                              child: Text(
                                widget.subscription.status ==
                                        SubscriptionStatus.expired
                                    ? 'تجديد الاشتراك'
                                    : 'تمديد الاشتراك',
                              ),
                            ),

                            TextButton(
                              onPressed: () async {
                                final confirm = await showConfirmDialog(
                                  context,
                                  title: 'تأكيد الحذف',
                                  message: 'هل أنت متأكد من حذف هذا العضو؟',
                                );

                                if (confirm) {
                                  deleteMember();
                                }
                              },
                              child: const Text(
                                'حذف',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),

                            TextButton(
                              onPressed: updateMember,
                              child: const Text(
                                'تحديث',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('إغلاق'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionsMeberList extends StatelessWidget {
  const SubscriptionsMeberList({super.key, required this.history});
  final List<MemberSubscriptionModel> history;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withAlpha(150)),
          ),
          child: Column(children: [Text('عدد الاشتراكات: ${history.length}')]),
        );
      },
    );
  }
}

class DisplayData extends StatelessWidget {
  const DisplayData({super.key, required this.label, this.child, this.child2});

  final String label;
  final String? child, child2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withAlpha(150)),
      ),
      child: Column(
        children: [
          ItemDisplayData(label: label, child: child, child2: child2 ?? ''),
        ],
      ),
    );
  }
}

class ItemDisplayData extends StatelessWidget {
  const ItemDisplayData({
    super.key,
    required this.label,
    this.child,
    this.child2,
  });

  final String label;
  final String? child2, child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text('$label :', style: AppStyle.style20W500),
          Text(
            ' ${FormatDateHelper.formatDate(child)}',
            style: AppStyle.style20.copyWith(
              color: Colors.white.withAlpha(200),
            ),
          ),
          Text(
            ' ${child2}',
            style: AppStyle.style20.copyWith(
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('إلغاء'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('تأكيد', style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        },
      ) ??
      false;
}
