part of 'report_filter_cubit.dart';

class ReportFilterState {
  final int year;
  final int month;
  final DateTime? selectedDay;

  const ReportFilterState({
    required this.year,
    required this.month,
    this.selectedDay,
  });

  ReportFilterState copyWith({int? year, int? month, DateTime? selectedDay}) {
    return ReportFilterState(
      year: year ?? this.year,
      month: month ?? this.month,
      selectedDay: selectedDay,
    );
  }
}
