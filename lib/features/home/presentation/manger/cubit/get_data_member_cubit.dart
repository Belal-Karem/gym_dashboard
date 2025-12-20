import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:power_gym/features/home/data/models/repo/get_data_member_repo_impl.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

part 'get_data_member_state.dart';

class GetDataMemberCubit extends Cubit<GetDataMemberState> {
  final GetDataMemberRepoImpl getDataMemberRepoImpl;
  StreamSubscription<List<MemberModel>>? _memberSubscription;

  GetDataMemberCubit(this.getDataMemberRepoImpl)
    : super(GetDataMemberInitial());

  Future<void> loadData() async {
    emit(GetDataMemberLoading());
    final result = await getDataMemberRepoImpl.getDataMember();
    result.fold(
      (failure) {
        emit(GetDataMemberError(failure.message));
      },
      (memberStream) {
        _memberSubscription?.cancel();
        _memberSubscription = memberStream.listen((members) {
          emit(GetDataMemberLoaded(members));
        });
      },
    );
  }

  @override
  Future<void> close() {
    _memberSubscription?.cancel();
    return super.close();
  }
}
