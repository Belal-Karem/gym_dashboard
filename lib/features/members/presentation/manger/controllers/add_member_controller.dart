import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/actions/member_actions.dart';
import 'package:power_gym/features/members/presentation/view/select_sup_view.dart';
import 'package:power_gym/features/payment/data/models/model/payment_model.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

class AddMemberController {
  final name = TextEditingController();
  final phone = TextEditingController();
  final note = TextEditingController();
  final startDate = TextEditingController();
  final joinDate = TextEditingController();

  String gender = 'ذكر';
  String status = 'نشط';
  String paymentMethod = 'نقدي';

  final formKey = GlobalKey<FormState>();

  void setGender(value) => gender = value;
  void setStatus(value) => status = value;
  void setpaymentMethod(value) => paymentMethod = value;

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
      final DateTime parsedStartDate = DateTime.parse(startDate.text);

      final memberId = await MemberActions.saveMemberAndSubscription(
        context: context,
        startDate: parsedStartDate,
        member: MemberModel(
          id: '',
          memberId: '',
          name: name.text,
          phone: phone.text,
          gender: gender,
          note: note.text,
          affiliationDate: DateTime.now(),
        ),
        selectedSub: selectedSub,
      );

      if (memberId != null) {
        context.read<PaymentCubit>().addPayment(
          PaymentModel(
            id: '',
            memberId: memberId,
            paid: selectedSub.price.toString(),
            plan: selectedSub.type,
            date: DateTime.now(),
            paymentMethod: paymentMethod,
            type: name.text,
            status: 'income',
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ غير متوقع: $e')));
    }
  }
}
