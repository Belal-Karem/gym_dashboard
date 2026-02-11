import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/peivate/data/models/private_model/private_model.dart';
import 'package:power_gym/features/peivate/data/models/repo/Private_repo.dart';
import 'package:power_gym/features/peivate/presentation/manger/cubit/private_attendance_state.dart';

// class PrivateAttendanceCubit extends Cubit<PrivateAttendanceState> {
//   final PrivateRepo repo;

//   PrivateAttendanceCubit(this.repo) : super(PrivateAttendanceInitial());

//   Future<void> attend(PrivateModel private) async {
//     if (private.isFinished) {
//       emit(PrivateAttendanceError('الحصص خلصت'));
//       return;
//     }

//     emit(PrivateAttendanceActionLoading());

//     final memberId = plan.member.id; // خزنه قبل await

//     final result = await repo.attendPrivate(plan.id);

//     result.fold((f) => emit(PrivateAttendanceError(f.message)), (_) async {
//       final updated = await repo.getActivePrivatep(memberId);

//       if (updated == null) {
//         emit(PrivateAttendanceEmpty());
//       } else {
//         emit(PrivateAttendanceLoaded(updated));
//       }
//     });
//   }
// }
