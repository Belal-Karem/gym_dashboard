import 'package:flutter/material.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/actions/member_actions.dart';
import 'package:power_gym/features/members/presentation/view/select_sup_view.dart';
import 'package:power_gym/features/payment/presentation/manger/actions/payment_actions.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

class AddMemberController {
  final name = TextEditingController();
  final phone = TextEditingController();
  final note = TextEditingController();
  final startDate = TextEditingController();
  final joinDate = TextEditingController();

  String gender = 'ذكر';
  String status = 'نشط';

  final formKey = GlobalKey<FormState>();

  void setGender(value) => gender = value;
  void setStatus(value) => status = value;

  // void setGender(String? value) {
  //   if (value != null) gender = value;
  // }

  // void setStatus(String? value) {
  //   if (value != null) status = value;
  // }

  void dispose() {
    name.dispose();
    phone.dispose();
    note.dispose();
    startDate.dispose();
    joinDate.dispose();
  }

  Future<void> onSave(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('يرجى تصحيح الأخطاء')));
      return;
    }

    final selectedSub = await Navigator.push<SubModel>(
      context,
      MaterialPageRoute(builder: (_) => const SelectSupView()),
    );

    if (selectedSub == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("يرجى اختيار مدة الاشتراك")));
      return;
    }

    try {
      final memberId = await MemberActions.saveMemberAndSubscription(
        context: context,
        member: MemberModel(
          id: '',
          memberId: '',
          name: name.text,
          phone: phone.text,
          startdata: startDate.text,
          gender: gender,
          note: note.text,
          status: status,
          attendance: '0',
          endDate: '',
          remainingDays: '0',
          affiliationdate: DateTime.now().toIso8601String(),
        ),
        selectedSub: selectedSub,
      );

      if (memberId != null) {
        await PaymentActions.recordPayment(
          memberId: memberId,
          paid: selectedSub.price,
          plan: selectedSub.type,
          paymentMethod: "كاش",
          date: DateTime.now(),
          name: name.text,
          status: 'income',
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ غير متوقع: $e')));
    }
  }
}
