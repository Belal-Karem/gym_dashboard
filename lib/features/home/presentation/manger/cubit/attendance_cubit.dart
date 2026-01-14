import 'package:bloc/bloc.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceRepo repo;

  AttendanceCubit(this.repo) : super(AttendanceInitial());

  Future<void> markPresent({
    required MemberSubscriptionModel subscription,
    required MemberModel member,
    required SubModel plan, // حاليًا مش مستخد
  }) async {
    try {
      await repo.markAttendance(member, subscription);
      emit(AttendanceSuccess());
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }
}
