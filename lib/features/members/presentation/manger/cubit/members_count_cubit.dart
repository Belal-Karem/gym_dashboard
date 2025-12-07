import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:power_gym/features/members/data/models/member_model/members_count_mode.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo.dart';

part 'members_count_state.dart';

class MembersCountStatsCubit extends Cubit<MembersStatsState> {
  final MemberRepo repo;
  StreamSubscription? _membersSubscription;

  MembersCountStatsCubit(this.repo) : super(MembersStatsInitial());

  void loadStats() async {
    emit(MembersStatsLoading());

    final result = await repo.getAllMembers();
    result.fold((failure) => emit(MembersStatsError(failure.message)), (
      stream,
    ) {
      _membersSubscription = stream.listen((members) {
        final men = members
            .where((m) => m.gender.toLowerCase() == 'ذكر')
            .length;
        final women = members
            .where((m) => m.gender.toLowerCase() == 'أنثى')
            .length;
        final children = members
            .where((m) => m.gender.toLowerCase() == 'طفل')
            .length;
        final active = members
            .where((m) => m.status.toLowerCase() == 'نشط')
            .length;
        final expired = members
            .where((m) => m.status.toLowerCase() != 'نشط')
            .length;

        emit(
          MembersStatsLoaded(
            MembersCountMode(
              men: men,
              women: women,
              children: children,
              active: active,
              expired: expired,
            ),
          ),
        );
      }, onError: (error) => emit(MembersStatsError(error.toString())));
    });
  }

  @override
  Future<void> close() {
    _membersSubscription?.cancel();
    return super.close();
  }
}
