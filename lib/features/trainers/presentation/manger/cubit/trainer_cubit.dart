import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:power_gym/features/trainers/data/models/repo/trainer_repo.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';

part 'trainer_state.dart';

class TrainerCubit extends Cubit<TrainerState> {
  final TrainerRepo repo;

  StreamSubscription? _trainerSubscription;

  TrainerCubit(this.repo) : super(TrainerInitial());

  Future<void> loadTrainer() async {
    emit(TrainerLoading());

    final result = await repo.getAllTrainers();

    result.fold((failure) => emit(TrainerError(failure.message)), (stream) {
      _trainerSubscription = stream.listen(
        (trainer) {
          emit(TrainerLoaded(trainer));
        },
        onError: (error) {
          emit(TrainerError(error.toString()));
        },
      );
    });
  }

  Future<void> addTrainer(TrainerModel trainer) async {
    emit(AddTrainerLoading());

    final result = await repo.addTrainer(trainer);

    result.fold(
      (failure) => emit(AddTrainerError(failure.message)),
      (_) => emit(AddTrainerSuccess()),
    );
  }

  Future<void> updateTrainer(String id, Map<String, dynamic> data) async {
    emit(UpdateTrainerLoading());

    final result = await repo.updateTrainer(id, data);

    result.fold(
      (failure) => emit(UpdateTrainerError(failure.message)),
      (_) => emit(UpdateTrainerSuccess()),
    );
  }

  Future<void> deleteTrainer(String id) async {
    emit(DeleteTrainerLoading());

    final result = await repo.deleteTrainer(id);

    result.fold(
      (failure) => emit(DeleteTrainerError(failure.message)),
      (_) => emit(DeleteTrainerSuccess()),
    );
  }

  @override
  Future<void> close() {
    _trainerSubscription?.cancel();
    return super.close();
  }
}
