import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/report_filter_cubit.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportFilterCubit, ReportFilterState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                dropdownColor: const Color(0xff1B1C20),
                value: state.month,
                decoration: _decoration('Month'),
                items: List.generate(12, (index) {
                  final month = index + 1;
                  return DropdownMenuItem(
                    value: month,
                    child: Text(
                      _monthName(month),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }),
                onChanged: (value) {
                  if (value != null) {
                    context.read<ReportFilterCubit>().changeMonth(value);
                  }
                },
              ),
            ),

            const SizedBox(width: 12),

            /// Year Dropdown
            Expanded(
              child: DropdownButtonFormField<int>(
                dropdownColor: const Color(0xff1B1C20),
                value: state.year,
                decoration: _decoration('Year'),
                items: List.generate(5, (index) {
                  final year = DateTime.now().year - index;
                  return DropdownMenuItem(
                    value: year,
                    child: Text(
                      year.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }),
                onChanged: (value) {
                  if (value != null) {
                    context.read<ReportFilterCubit>().changeYear(value);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: const Color(0xff1B1C20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'يناير،',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    return months[month - 1];
  }
}
