import 'package:dartz/dartz.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

import '../../../../../core/errors/failure.dart';

abstract class SubRepo {
  Future<Either<Failure, Stream<List<SubModel>>>> getAllSub();

  Future<Either<Failure, Unit>> addSub(SubModel member);

  Future<Either<Failure, Unit>> updateSub(String id, Map<String, dynamic> data);

  Future<Either<Failure, Unit>> deleteSub(String id);
}
