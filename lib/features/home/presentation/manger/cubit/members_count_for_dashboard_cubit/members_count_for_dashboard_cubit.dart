import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/members_count_for_dashboard_cubit/members_count_for_dashboard_state.dart';
import 'package:power_gym/features/members/data/models/member_model/members_count_mode.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo.dart';

class MembersCountForDashboardCubit
    extends Cubit<MembersCountForDashboardState> {
  final MemberRepo repo;
  StreamSubscription? _membersSubscription;

  MembersCountForDashboardCubit(this.repo)
    : super(MembersCountForDashboardInitial());

  void loadCount() async {
    emit(MembersCountForDashboardLoading());

    final result = await repo.getAllMembers();

    result.fold(
      (failure) => emit(MembersCountForDashboardError(failure.message)),
      (stream) {
        _membersSubscription = stream.listen(
          (members) {
            final totalCount = members.length;

            emit(
              MembersCountForDashboardLoaded(
                MembersCountMode(
                  total: totalCount,
                  men: 0,
                  women: 0,
                  children: 0,
                  active: 0,
                  expired: 0,
                ),
              ),
            );
          },
          onError: (error) =>
              emit(MembersCountForDashboardError(error.toString())),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _membersSubscription?.cancel();
    return super.close();
  }
}
