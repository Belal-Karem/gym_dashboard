import 'package:dartz/dartz.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/features/peivate/data/models/private_model/private_model.dart';

abstract class PrivateRepo {
  Future<Either<Failure, Stream<List<PrivateModel>>>> getAllPrivate();

  Future<Either<Failure, Unit>> addPrivate(PrivateModel plan);

  Future<Either<Failure, Unit>> updatePrivate(
    String id,
    Map<String, dynamic> data,
  );

  Future<Either<Failure, Unit>> deletePrivate(String id);

  Future<bool> hasActivePrivatePlan(String memberId);
}
