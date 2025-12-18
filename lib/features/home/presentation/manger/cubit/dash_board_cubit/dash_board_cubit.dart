import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:power_gym/features/home/data/models/model/dash_board_model.dart';
import 'package:power_gym/features/home/data/models/repo/dash_board_repo.dart';

part 'dash_board_state.dart';

class DashBoardCubit extends Cubit<DashBoardState> {
  final DashBoardRepo repo;
  StreamSubscription? _dashboardSubscription;

  DashBoardCubit(this.repo) : super(DashBoardInitial());

  Future<void> loadDashboard() async {
    emit(DashBoardLoading());

    final result = await repo.getAllDashBoard();

    result.fold((failure) => emit(DashBoardError(failure.message)), (stream) {
      _dashboardSubscription = stream.listen(
        (members) {
          final updatedList = members.map((member) {
            final sub = member.subscription;

            // حساب الحالة محلي فقط (من غير update)
            if (sub != null && sub.isExpired) {
              return member.copyWith(status: 'منتهي');
            }

            return member;
          }).toList();

          emit(DashBoardLoaded(updatedList));
        },
        onError: (error) {
          emit(DashBoardError(error.toString()));
        },
      );
    });
  }

  @override
  Future<void> close() {
    _dashboardSubscription?.cancel();
    return super.close();
  }
}
