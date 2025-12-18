import 'package:flutter/material.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
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
  String gender = 'ذكر';
  String status = 'نشط';

  final formKey = GlobalKey<FormState>();

  void setGender(value) => gender = value;
  void setStatus(value) => status = value;

  void dispose() {
    name.dispose();
    phone.dispose();
    note.dispose();
    startDate.dispose();
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
          startDate: DateTime.parse(startDate.text),
          gender: gender,
          note: note.text,
          status: status,
          attendance: 0,
          subscription: MemberSubscriptionModel(
            memberId: '',
            subId: 'default',
            startDate: DateTime.parse(startDate.text),
            endDate: DateTime.parse(startDate.text),
            status: 'بدون اشتراك',
          ),
          joinDate: DateTime.now(),
          freeze: selectedSub.freeze,
          invites: selectedSub.invitation,
        ),
        selectedSub: selectedSub,
      );

      if (memberId != null) {
        await PaymentActions.recordPayment(
          memberId: memberId,
          paid: double.tryParse(selectedSub.price) ?? 0,
          plan: selectedSub.type,
          date: DateTime.now(),
          name: name.text,
          paymentMethod: "كاش",
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ غير متوقع: $e')));
    }
  }
}

// DateTime parseCustomDate(String input) {
//   try {
//     final parts = input.split('-');
//     if (parts.length != 3) throw Exception();

//     final day = int.parse(parts[0]);
//     final month = int.parse(parts[1]);
//     final year = int.parse(parts[2]);

//     return DateTime(year, month, day);
//   } catch (e) {
//     throw FormatException('Invalid date format: $input');
//   }
// }
