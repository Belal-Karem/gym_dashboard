part of 'dashboard_cubit.dart';

abstract class GetTodayAttendanceState {}

class GetTodayAttendanceInitial extends GetTodayAttendanceState {}

class GetTodayAttendanceLoading extends GetTodayAttendanceState {}

class GetTodayAttendanceLoaded extends GetTodayAttendanceState {
  final int todayAttendanceCount;

  GetTodayAttendanceLoaded(this.todayAttendanceCount);
}

class GetTodayAttendanceError extends GetTodayAttendanceState {
  final String message;
  GetTodayAttendanceError(this.message);
}
