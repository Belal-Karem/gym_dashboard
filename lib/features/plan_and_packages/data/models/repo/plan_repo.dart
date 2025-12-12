import 'package:dartz/dartz.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/features/plan_and_packages/data/models/plan_model/plan_model.dart';

abstract class PlanRepo {
  Future<Either<Failure, Stream<List<PlanModel>>>> getAllPlan();

  Future<Either<Failure, Unit>> addPlan(PlanModel member);

  Future<Either<Failure, Unit>> updatePlan(
    String id,
    Map<String, dynamic> data,
  );

  Future<Either<Failure, Unit>> deletePlan(String id);
}
