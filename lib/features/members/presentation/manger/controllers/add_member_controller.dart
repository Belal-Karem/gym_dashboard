import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_error_widget.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/presentation/manger/actions/member_actions.dart';
import 'package:power_gym/features/members/presentation/view/select_sup_view.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

class AddMemberController {
  final name = TextEditingController();
  final phone = TextEditingController();
  final note = TextEditingController();
  final startDate = TextEditingController();
  final joinDate = TextEditingController();

  String? gender = 'ذكر';
  String? status = 'active';

  final formKey = GlobalKey<FormState>();

  void setGender(dynamic value) => gender = value;
  void setStatus(dynamic value) => status = value;

  void dispose() {
    name.dispose();
    phone.dispose();
    note.dispose();
    startDate.dispose();
    joinDate.dispose();
  }

  Future<void> onSave(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      CustomErrorWidget(errMessage: 'يرجى تصحيح الأخطاء');
      return;
    }

    final selectedSub = await Navigator.push<SubModel>(
      context,
      MaterialPageRoute(builder: (_) => const SelectSupView()),
    );

    if (selectedSub == null) {
      CustomErrorWidget(errMessage: "يرجى اختيار مدة الاشتراك");
      return;
    }

    await MemberActions.saveMemberAndSubscription(
      context: context,
      member: MemberModel(
        id: '',
        name: name.text,
        phone: phone.text,
        startdata: startDate.text,
        gender: gender!,
        note: note.text,
        status: 'نشط',
        memberId: '',
        enddata: '',
        attendance: '0',
        absence: '0',
      ),
      selectedSub: selectedSub,
    );
  }
}
