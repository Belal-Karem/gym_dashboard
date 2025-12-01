import 'package:dartz/dartz.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

import '../../../../../core/errors/failure.dart';

abstract class MemberRepo {
  Future<Either<Failure, Stream<List<MemberModel>>>> getAllMembers();

  Future<Either<Failure, Unit>> addMember(MemberModel member);

  Future<Either<Failure, Unit>> updateMember(
    String id,
    Map<String, dynamic> data,
  );

  Future<Either<Failure, Unit>> deleteMember(String id);
}
