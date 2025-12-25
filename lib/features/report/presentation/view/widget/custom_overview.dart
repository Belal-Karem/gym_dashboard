import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_report_comment_cubit.dart';
import 'package:power_gym/features/report/presentation/view/widget/list_title_item.dart';
import 'package:power_gym/model/list_title_overview_model.dart';

class CustomOverview extends StatelessWidget {
  const CustomOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ملخص', style: AppStyle.style20W500),
        SizedBox(height: 10),
        ListTitleItem(
          listTitleOverviewModel: ListTitleOverviewModel(
            text: 'تاريخ',
            data: '5 نوفمبر 2025',
            icon: Icons.calendar_month,
          ),
        ),
        ListTitleItem(
          listTitleOverviewModel: ListTitleOverviewModel(
            text: 'ساعات العمل',
            data: '24h',
            icon: FontAwesomeIcons.clock,
          ),
        ),
        ListTitleItem(
          listTitleOverviewModel: ListTitleOverviewModel(
            text: 'إجمالي الزيارات',
            data: '27',
            icon: Icons.person,
          ),
        ),
        BlocBuilder<DailyReportCommentCubit, DailyReportCommentState>(
          builder: (context, state) {
            if (state is DailyReportCommentStateLoading) {
              return const CircularProgressIndicator();
            }
            if (state is DailyReportCommentStateLoaded) {
              return ListTitleItem(
                listTitleOverviewModel: ListTitleOverviewModel(
                  text: 'الموضوع',
                  data: state.comment?.comment ?? 'No comment for this day',
                  icon: Icons.subject,
                ),
              );
            }
            if (state is DailyReportCommentStateError) {
              return Text('Error: ${state.message}');
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
