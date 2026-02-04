import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/plan_and_packages/data/models/plan_model/plan_model.dart';
import 'package:power_gym/features/plan_and_packages/data/models/repo/plan_repo.dart';
import 'package:power_gym/features/plan_and_packages/presentation/manger/cubit/private_attendance_state.dart';

// class PrivateAttendanceCubit extends Cubit<PrivateAttendanceState> {
//   final PlanRepo repo;

//   PrivateAttendanceCubit(this.repo) : super(PrivateAttendanceInitial());

//   Future<void> attend(PlanModel plan) async {
//     if (plan.isFinished) {
//       emit(PrivateAttendanceError('الحصص خلصت'));
//       return;
//     }

//     emit(PrivateAttendanceActionLoading());

//     final memberId = plan.member.id; // خزنه قبل await

//     final result = await repo.attendPrivate(plan.id);

//     result.fold((f) => emit(PrivateAttendanceError(f.message)), (_) async {
//       final updated = await repo.getActivePrivatePlan(memberId);

//       if (updated == null) {
//         emit(PrivateAttendanceEmpty());
//       } else {
//         emit(PrivateAttendanceLoaded(updated));
//       }
//     });
//   }
// }
