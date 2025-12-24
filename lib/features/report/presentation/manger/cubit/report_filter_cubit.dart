import 'package:bloc/bloc.dart';

part 'report_filter_state.dart';

class ReportFilterCubit extends Cubit<ReportFilterState> {
  ReportFilterCubit()
    : super(
        ReportFilterState(
          year: DateTime.now().year,
          month: DateTime.now().month,
          selectedDay: null,
        ),
      );

  void changeYear(int year) {
    emit(
      state.copyWith(
        year: year,
        selectedDay: null, // مهم
      ),
    );
  }

  void changeMonth(int month) {
    emit(
      state.copyWith(
        month: month,
        selectedDay: null, // نلغي اليوم المختار
      ),
    );
  }

  void selectDay(DateTime day) {
    emit(state.copyWith(selectedDay: day));
  }

  /// helper مهم جدًا
  String? get selectedDateId {
    if (state.selectedDay == null) return null;
    final d = state.selectedDay!;
    return '${d.year}-${_two(d.month)}-${_two(d.day)}';
  }

  String _two(int n) => n.toString().padLeft(2, '0');
}
