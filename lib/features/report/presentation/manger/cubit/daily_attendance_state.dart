part of 'daily_attendance_cubit.dart';

abstract class DailyAttendanceState {}

class DailyAttendanceInitial extends DailyAttendanceState {}

class DailyAttendanceLoading extends DailyAttendanceState {}

class DailyAttendanceLoaded extends DailyAttendanceState {
  final List<AttendanceReportModel> attendance;
  DailyAttendanceLoaded(this.attendance);
}

class DailyAttendanceError extends DailyAttendanceState {
  final String message;
  DailyAttendanceError(this.message);
}
