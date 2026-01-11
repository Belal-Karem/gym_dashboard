import 'package:bloc/bloc.dart';

class ReportFilterCubit extends Cubit<ReportFilterState> {
  ReportFilterCubit()
    : super(
        ReportFilterState(
          month: DateTime.now().month,
          year: DateTime.now().year,
        ),
      );

  void changeMonth(int month) {
    emit(ReportFilterState(month: month, year: state.year));
  }

  void changeYear(int year) {
    emit(ReportFilterState(month: state.month, year: year));
  }
}

class ReportFilterState {
  final int month;
  final int year;

  ReportFilterState({required this.month, required this.year});
}
