part of 'today_attendance_cubit.dart';

abstract class TodayAttendanceState {}

class TodayAttendanceInitial extends TodayAttendanceState {}

class TodayAttendanceLoading extends TodayAttendanceState {}

class TodayAttendanceLoaded extends TodayAttendanceState {
  final List<String> memberIds; // IDs اللي حضروا النهارده

  TodayAttendanceLoaded(this.memberIds);
}

class TodayAttendanceError extends TodayAttendanceState {
  final String message;

  TodayAttendanceError(this.message);
}
