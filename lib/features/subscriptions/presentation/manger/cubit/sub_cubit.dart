import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:power_gym/features/subscriptions/data/models/repo/sub_repo.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_state.dart';

class SubCubit extends Cubit<SubState> {
  final SubRepo repo;
  StreamSubscription? _subSubscription;

  SubCubit(this.repo) : super(SubInitial());

  Future<void> loadSub() async {
    emit(SubLoading());

    final result = await repo.getAllSub();

    result.fold((failure) => emit(SubError(failure.message)), (stream) {
      _subSubscription?.cancel();
      _subSubscription = stream.listen(
        (subs) {
          emit(SubLoaded(subs)); // المصدر الوحيد للعرض
        },
        onError: (error) {
          emit(SubError(error.toString()));
        },
      );
    });
  }

  Future<void> addSub(SubModel sub) async {
    final result = await repo.addSub(sub);

    result.fold(
      (failure) => emit(AddSubError(failure.message)),
      (_) {}, // 👈 سيب الـ Stream
    );
  }

  Future<void> updateSub(String id, Map<String, dynamic> data) async {
    final result = await repo.updateSub(id, data);

    result.fold(
      (failure) => emit(UpdateSubError(failure.message)),
      (_) {}, // 👈 سيب الـ Stream
    );
  }

  Future<void> deleteSub(String id) async {
    final result = await repo.deleteSub(id);

    result.fold(
      (failure) => emit(DeleteSubError(failure.message)),
      (_) {}, // 👈 سيب الـ Stream
    );
  }

  @override
  Future<void> close() {
    _subSubscription?.cancel();
    return super.close();
  }
}
