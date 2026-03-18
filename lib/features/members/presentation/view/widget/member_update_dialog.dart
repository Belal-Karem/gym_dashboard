import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/utils/date_utils.dart';
import 'package:power_gym/core/widget/custom_dropdown_widget.dart';
import 'package:power_gym/core/widget/double_field_row_add_widget.dart';
import 'package:power_gym/core/widget/field_label_and_input_add_widget.dart';
import 'package:power_gym/core/widget/show_confirm_dialog.dart';
import 'package:power_gym/core/widget/text_field_add_widget.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/view/select_sup_view.dart';
import 'package:power_gym/features/members/presentation/view/widget/display_data_for_member.dart';
import 'package:power_gym/features/members/presentation/view/widget/subscriptions_member_list.dart';
import 'package:power_gym/features/peivate/presentation/view/widget/dialog_add_plan.dart';
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
                          child: SubscriptionsMemberList(
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
                        DisplayDataForMember(
                          label: 'تاريخ الانضمام',
                          child: affiliationdate.toString(),
                        ),
                        DisplayDataForMember(
                          label: 'تاريخ البدء',
                          child: startDate.toString(),
                        ),
                        DisplayDataForMember(
                          label: 'تاريخ النتهاء',
                          child: endDate.toString(),
                        ),

                        DisplayDataForMember(
                          label: 'الايام المتبقيه',
                          child2: remainingDays.toString(),
                        ),
                        DisplayDataForMember(
                          label: 'التجميد',
                          child2: freeze.toString(),
                        ),
                        DisplayDataForMember(
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
                                openAddPlanDialog(context, widget.member);
                              },
                              child: const Text(
                                'اشتراك بريفت',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),

                            /// لو الاشتراك منتهي → تجديد
                            if (widget.subscription.status ==
                                SubscriptionStatus.expired)
                              TextButton(
                                onPressed: () => _handleRenew(context),
                                child: const Text('تجديد الاشتراك'),
                              ),

                            /// لو الاشتراك شغال → تمديد
                            if (widget.subscription.status ==
                                SubscriptionStatus.active)
                              TextButton(
                                onPressed: () => _handleExtend(context),
                                child: const Text('تمديد الاشتراك'),
                              ),

                            /// زرار اشتراك جديد (يظهر في كل الحالات)
                            if (widget.subscription.status !=
                                SubscriptionStatus.expired)
                              TextButton(
                                onPressed: () =>
                                    _handleNewSubscription(context),
                                child: const Text('إضافة اشتراك جديد'),
                              ),

                            const Spacer(),
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

  Future<void> _handleNewSubscription(BuildContext context) async {
    final cubit = context.read<MemberSubscriptionCubit>();

    DateTime minStartDate = DateTime.now();

    if (widget.subscription.status == SubscriptionStatus.active) {
      minStartDate = widget.subscription.endDate;
    }

    final DateTime? startDate = await showDatePicker(
      context: context,
      initialDate: minStartDate,
      firstDate: minStartDate, // 👈 هنا المهم
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
        const SnackBar(content: Text('يرجى اختيار تاريخ البداية')),
      );
      return;
    }

    final selectedSub = await Navigator.push<SubModel>(
      context,
      MaterialPageRoute(builder: (_) => const SelectSupView()),
    );

    if (selectedSub == null) return;

    final now = DateTime.now();

    cubit.addSubscription(
      MemberSubscriptionModel(
        id: '',
        memberId: widget.subscription.memberId,
        subscriptionId: selectedSub.id,
        startDate: startDate, // الكيوبت هيعدلها لو فيه Active
        endDate: startDate.add(Duration(days: selectedSub.durationDays)),
        actionDate: now,
        isRenewal: false, // 👈 مهم جداً
        remainingDays: selectedSub.durationDays,
        attendance: 0,
        dateId: generateDateId(now),
        status: SubscriptionStatus.active,
        dateIdForReport: generateDateId(now),
        freezeEndDate: now,
        totalInvitations: selectedSub.invitationCount,
        usedInvitations: 0,
        freeze: selectedSub.freezeDays,
        maxAttendance: selectedSub.maxAttendance,
      ),
    );
  }

  Future<void> _handleExtend(BuildContext context) async {
    final cubit = context.read<MemberSubscriptionCubit>();

    final selectedSub = await Navigator.push<SubModel>(
      context,
      MaterialPageRoute(builder: (_) => const SelectSupView()),
    );

    if (selectedSub == null) return;

    cubit.renewOrExtendSubscription(
      currentSub: widget.subscription,
      plan: selectedSub,
    );
  }

  Future<void> _handleRenew(BuildContext context) async {
    final cubit = context.read<MemberSubscriptionCubit>();

    final selectedSub = await Navigator.push<SubModel>(
      context,
      MaterialPageRoute(builder: (_) => const SelectSupView()),
    );

    if (selectedSub == null) return;

    cubit.renewOrExtendSubscription(
      currentSub: widget.subscription,
      plan: selectedSub,
    );
  }
}
