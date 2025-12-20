import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/utils/constants.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/attendance_cubit.dart';
import 'package:power_gym/features/home/presentation/view/widget/list_title_member_info.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/model/show_dialog_data_member_Info_model.dart';

class ShowDialogDataMemberInfo extends StatelessWidget {
  const ShowDialogDataMemberInfo({super.key, required this.member});
  final MemberModel member;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AttendanceCubit, AttendanceState>(
      listener: (context, state) {
        if (state is AttendanceSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('تم تسجيل الحضور ✅')));
        }

        if (state is AttendanceError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
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
                    showDialogDataMemberInfoModel:
                        ShowDialogDataMemberInfoModel(
                          title: 'اسم',
                          trailing: member.name,
                        ),
                  ),
                  ListTitleMemberInfo(
                    showDialogDataMemberInfoModel:
                        ShowDialogDataMemberInfoModel(
                          title: 'هاتف',
                          trailing: member.phone,
                        ),
                  ),
                  ListTitleMemberInfo(
                    showDialogDataMemberInfoModel:
                        ShowDialogDataMemberInfoModel(
                          title: 'النوع',
                          trailing: member.gender,
                        ),
                  ),
                  ListTitleMemberInfo(
                    showDialogDataMemberInfoModel:
                        ShowDialogDataMemberInfoModel(
                          title: 'تاريخ الانضمام',
                          trailing: '15/01/2023',
                        ),
                  ),
                  ListTitleMemberInfo(
                    showDialogDataMemberInfoModel:
                        ShowDialogDataMemberInfoModel(
                          title: 'تاريخ النتهاء',
                          trailing: '15/01/2023',
                        ),
                  ),
                  ListTitleMemberInfo(
                    showDialogDataMemberInfoModel:
                        ShowDialogDataMemberInfoModel(
                          title: 'خطة الاشتراكات',
                          trailing: '3 أشهر',
                        ),
                  ),
                  ListTitleMemberInfo(
                    showDialogDataMemberInfoModel:
                        ShowDialogDataMemberInfoModel(
                          title: 'الحضور',
                          trailing: '120',
                        ),
                  ),

                  ListTitleMemberInfo(
                    showDialogDataMemberInfoModel:
                        ShowDialogDataMemberInfoModel(
                          title: 'دعوه',
                          trailing: '3',
                        ),
                  ),
                  ListTitleMemberInfo(
                    showDialogDataMemberInfoModel:
                        ShowDialogDataMemberInfoModel(
                          title: 'تجميد',
                          trailing: '10',
                        ),
                  ),
                  ListTitleMemberInfo(
                    leadingAndTrailingTextStyle: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 13, 223, 20),
                    ),
                    showDialogDataMemberInfoModel:
                        ShowDialogDataMemberInfoModel(
                          title: 'حالة',
                          trailing: member.status,
                        ),
                  ),
                  ListTitleMemberInfo(
                    showDialogDataMemberInfoModel:
                        ShowDialogDataMemberInfoModel(
                          title: 'مدرب',
                          trailing: 'أحمد علي',
                        ),
                  ),
                  ListTitleMemberInfo(
                    showDialogDataMemberInfoModel:
                        ShowDialogDataMemberInfoModel(
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
                          context.read<AttendanceCubit>().markPresent(member);
                        },
                      ),
                      ElevatedBouttonMemberInfo(
                        text: 'تجميد',
                        onPressed: () {},
                      ),
                      ElevatedBouttonMemberInfo(
                        text: 'دعوه',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
