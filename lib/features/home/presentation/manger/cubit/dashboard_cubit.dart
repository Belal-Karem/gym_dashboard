import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';

part 'dashboard_state.dart';

class GetTodayAttendanceCubit extends Cubit<GetTodayAttendanceState> {
  final AttendanceRepo repo;
  StreamSubscription<int>? _sub;

  GetTodayAttendanceCubit(this.repo) : super(GetTodayAttendanceInitial());

  void loadGetTodayAttendance() {
    emit(GetTodayAttendanceLoading());

    _sub?.cancel();
    _sub = repo.getTodayAttendanceCount().listen(
      (count) {
        emit(GetTodayAttendanceLoaded(count));
      },
      onError: (e) {
        emit(GetTodayAttendanceError(e.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
