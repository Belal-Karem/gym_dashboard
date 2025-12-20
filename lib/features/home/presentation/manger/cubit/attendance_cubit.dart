import 'package:bloc/bloc.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceRepo repo;

  AttendanceCubit(this.repo) : super(AttendanceInitial());

  Future<void> markPresent(MemberModel member) async {
    emit(AttendanceLoading());

    try {
      await repo.markAttendance(member);
      emit(AttendanceSuccess());
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }
}
