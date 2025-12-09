// import 'package:flutter/material.dart';
// import 'package:power_gym/core/widget/custom_error_widget.dart';

// class AddPaymentController {
//   final type = TextEditingController();
//   final plan = TextEditingController();
//   final paid = TextEditingController();
//   final paymentData = TextEditingController();

//   String? paymentMethod = 'ذكر';

//   final formKey = GlobalKey<FormState>();

//   void setGender(dynamic value) => paymentMethod = value;

//   void dispose() {
//     type.dispose();
//     plan.dispose();
//     paid.dispose();
//     paymentData.dispose();
//   }

//   Future<void> onSave(BuildContext context) async {
//     if (!formKey.currentState!.validate()) {
//       CustomErrorWidget(errMessage: 'يرجى تصحيح الأخطاء');
//       return;
//     }

//     // final selectedSub = await Navigator.push<SubModel>(
//     //   context,
//     //   MaterialPageRoute(builder: (_) => const SelectSupView()),
//     // );

//     // if (selectedSub == null) {
//     //   CustomErrorWidget(errMessage: "يرجى اختيار مدة الاشتراك");
//     //   return;
//     // }

//     await MemberActions.saveMemberAndSubscription(
//       context: context,
//       member: MemberModel(
//         id: '',
//         name: name.text,
//         phone: phone.text,
//         startdata: startDate.text,
//         gender: gender!,
//         note: note.text,
//         status: 'نشط',
//         memberId: '',
//         enddata: '',
//         attendance: '0',
//         absence: '0',
//       ),
//       selectedSub: selectedSub,
//     );
//   }
// }
