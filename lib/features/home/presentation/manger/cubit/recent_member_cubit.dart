import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:power_gym/features/home/data/models/model/recent_member_model.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';

part 'recent_member_state.dart';

class RecentMemberCubit extends Cubit<RecentMemberState> {
  final AttendanceRepo repo;
  StreamSubscription? _sub;

  RecentMemberCubit(this.repo) : super(RecentMemberInitial());

  void loadRecent() {
    emit(RecentMemberLoading());

    _sub?.cancel();
    _sub = repo.getTodayRecentMembers().listen(
      (members) {
        emit(RecentMemberLoaded(members));
      },
      onError: (e) {
        emit(RecentMemberError(e.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
