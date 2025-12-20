import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final AttendanceRepo repo;
  StreamSubscription<int>? _sub;

  DashboardCubit(this.repo) : super(DashboardInitial());

  void loadDashboard() {
    emit(DashboardLoading());

    _sub?.cancel();
    _sub = repo.getTodayAttendanceCount().listen(
      (count) {
        emit(DashboardLoaded(count));
      },
      onError: (e) {
        emit(DashboardError(e.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
