import 'package:dartz/dartz.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';

abstract class TrainerRepo {
  Future<Either<Failure, Stream<List<TrainerModel>>>> getAllTrainers();

  Future<Either<Failure, Unit>> addTrainer(TrainerModel trainer);

  Future<Either<Failure, Unit>> updateTrainer(
    String id,
    Map<String, dynamic> data,
  );

  Future<Either<Failure, Unit>> deleteTrainer(String id);
}
