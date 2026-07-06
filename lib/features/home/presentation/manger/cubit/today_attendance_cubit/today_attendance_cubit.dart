import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';

part 'today_attendance_state.dart';

class TodayAttendanceCubit extends Cubit<TodayAttendanceState> {
  final AttendanceRepo repo;
  StreamSubscription<List<String>>? _sub;

  TodayAttendanceCubit(this.repo) : super(TodayAttendanceInitial());

  void loadToday() {
    emit(TodayAttendanceLoading());

    _sub?.cancel(); // مهم جدًا
    _sub = repo.getTodayAttendanceIds().listen(
      (ids) {
        emit(TodayAttendanceLoaded(ids));
      },
      onError: (e) {
        emit(TodayAttendanceError(e.toString()));
      },
    );
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
