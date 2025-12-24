import 'package:bloc/bloc.dart';
import 'package:power_gym/features/report/data/models/model/attendance_report_mode.dart';
import 'package:power_gym/features/report/data/models/repo/daily_attendance_repo.dart';

part 'daily_attendance_state.dart';

class DailyAttendanceCubit extends Cubit<DailyAttendanceState> {
  final DailyAttendanceRepo repo;

  DailyAttendanceCubit(this.repo) : super(DailyAttendanceInitial());

  Future<void> load(String dateId) async {
    emit(DailyAttendanceLoading());

    try {
      final data = await repo.getDailyAttendance(dateId);
      emit(DailyAttendanceLoaded(data));
    } catch (e) {
      emit(DailyAttendanceError(e.toString()));
    }
  }
}
