import 'package:dartz/dartz.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

abstract class MemberRepo {
  Future<Either<Failure, Stream<List<SubModel>>>> getAllMembers();

  Future<Either<Failure, Unit>> addMember(SubModel member);

  Future<Either<Failure, Unit>> updateMember(
    String id,
    Map<String, dynamic> data,
  );

  Future<Either<Failure, Unit>> deleteMember(String id);
}
