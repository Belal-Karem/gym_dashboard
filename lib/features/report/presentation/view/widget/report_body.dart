import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/report_filter_cubit.dart';
import 'package:power_gym/features/report/presentation/view/widget/custom_dropdown_button.dart';
import 'package:power_gym/features/report/presentation/view/widget/date_card.dart';

class ReportBody extends StatelessWidget {
  const ReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const CustomDropdownButton(),
          const SizedBox(height: 15),
          Expanded(
            child: BlocBuilder<ReportFilterCubit, ReportFilterState>(
              builder: (context, state) {
                final days = _generateDays(state.year, state.month);

                return GridView.builder(
                  itemCount: days.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.4,
                  ),
                  itemBuilder: (context, index) {
                    return DateCard(dayDate: days[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<DateTime> _generateDays(int year, int month) {
    final lastDay = DateTime(year, month + 1, 0).day;
    return List.generate(lastDay, (i) => DateTime(year, month, i + 1));
  }
}
