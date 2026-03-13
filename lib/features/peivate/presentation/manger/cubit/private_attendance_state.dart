import 'package:power_gym/features/peivate/data/models/private_model/private_model.dart';

abstract class PrivateAttendanceState {}

class PrivateAttendanceInitial extends PrivateAttendanceState {}

class PrivateAttendanceLoading extends PrivateAttendanceState {}

class PrivateAttendanceEmpty extends PrivateAttendanceState {}

class PrivateAttendanceLoaded extends PrivateAttendanceState {
  final PrivateModel plan;
  PrivateAttendanceLoaded(this.plan);
}

class PrivateAttendanceActionLoading extends PrivateAttendanceState {}

class PrivateAttendanceError extends PrivateAttendanceState {
  final String message;
  PrivateAttendanceError(this.message);
}
