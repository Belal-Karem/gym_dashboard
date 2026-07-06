import 'package:bloc/bloc.dart';
import 'package:power_gym/features/home/data/models/model/dash_board_model.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/attendance_cubit/attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceRepo repo;

  AttendanceCubit(this.repo) : super(AttendanceInitial());

  Future<void> markPresent(DashBoardModel member) async {
    emit(AttendanceLoading());

    final result = await repo.markAttendance(
      member.id,
      member.memberId,
      member.name,
    );

    result.fold(
      (failure) {
        emit(AttendanceError(failure.message));
      },
      (_) {
        emit(AttendanceSuccess());
      },
    );
  }
}
