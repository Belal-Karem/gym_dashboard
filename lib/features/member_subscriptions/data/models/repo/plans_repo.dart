import 'package:dartz/dartz.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

abstract class PlansRepo {
  Future<Either<Failure, SubModel>> getPlanById(String id);
}
