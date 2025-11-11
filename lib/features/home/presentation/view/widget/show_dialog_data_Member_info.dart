import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/utils/constants.dart';
import 'package:power_gym/features/home/presentation/view/widget/list_title_member_info.dart';
import 'package:power_gym/model/show_dialog_data_member_Info_model.dart';

class ShowDialogDataMemberInfo extends StatelessWidget {
  const ShowDialogDataMemberInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kprimaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text('معلومات العضو', style: AppStyle.style20W500),
            SizedBox(height: 20),
            ListTitleMemberInfo(
              showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                title: 'اسم',
                trailing: 'أحمد',
              ),
            ),
            ListTitleMemberInfo(
              showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                title: 'هاتف',
                trailing: '123456789',
              ),
            ),
            ListTitleMemberInfo(
              showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                title: 'جنس',
                trailing: 'ذكر',
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
                title: 'خطة الاشتراكات',
                trailing: '3 أشهر',
              ),
            ),
            ListTitleMemberInfo(
              leadingAndTrailingTextStyle: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 13, 223, 20),
              ),
              showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
                title: 'حالة',
                trailing: 'نشط',
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedBouttonMemberInfo(
                  text: 'تعديل العضو',
                  onPressed: () {},
                ),
                ElevatedBouttonMemberInfo(
                  text: 'يقبل',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ElevatedBouttonMemberInfo extends StatelessWidget {
  const ElevatedBouttonMemberInfo({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 15)),
      ),
    );
  }
}
