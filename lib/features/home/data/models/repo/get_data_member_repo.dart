import 'package:dartz/dartz.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

abstract class GetDataMemberRepo {
  Future<Either<Failure, Stream<List<MemberModel>>>> getDataMember();
}
