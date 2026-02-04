import 'package:power_gym/features/plan_and_packages/data/models/plan_model/plan_model.dart';

abstract class PrivateAttendanceState {}

class PrivateAttendanceInitial extends PrivateAttendanceState {}

class PrivateAttendanceLoading extends PrivateAttendanceState {}

class PrivateAttendanceEmpty extends PrivateAttendanceState {}

class PrivateAttendanceLoaded extends PrivateAttendanceState {
  final PlanModel plan;
  PrivateAttendanceLoaded(this.plan);
}

class PrivateAttendanceActionLoading extends PrivateAttendanceState {}

class PrivateAttendanceError extends PrivateAttendanceState {
  final String message;
  PrivateAttendanceError(this.message);
}
