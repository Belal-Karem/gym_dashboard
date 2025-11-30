import 'package:dartz/dartz.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

abstract class MemberRepo {
  Future<Either<Failure, Stream<List<MemberModel>>>> getAllMembers();

  Future<Either<Failure, Unit>> addMember(MemberModel member);

  Future<Either<Failure, Unit>> updateMember(
    String id,
    Map<String, dynamic> data,
  );

  Future<Either<Failure, Unit>> deleteMember(String id);
}

class Failure {
  final String message;
  Failure(this.message);
}
