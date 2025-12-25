part of 'attendance_cubit.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceSuccess extends AttendanceState {
  final MemberModel updatedMember;
  AttendanceSuccess(this.updatedMember);
}

class AttendanceError extends AttendanceState {
  final String message;
  AttendanceError(this.message);
}
