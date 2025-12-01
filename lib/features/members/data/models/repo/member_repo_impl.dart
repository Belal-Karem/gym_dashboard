import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo.dart';

class MemberRepoImpl implements MemberRepo {
  final CollectionReference membersRef = FirebaseFirestore.instance.collection(
    kMemberCollections,
  );

  @override
  Future<Either<Failure, Stream<List<MemberModel>>>> getAllMembers() async {
    try {
      final stream = membersRef.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return MemberModel.fromJson(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );
        }).toList();
      });

      return Right(stream);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addMember(MemberModel member) async {
    try {
      await membersRef.doc(member.id).set(member.toJson());
      return const Right(unit);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateMember(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await membersRef.doc(id).update(data);
      return const Right(unit);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMember(String id) async {
    try {
      await membersRef.doc(id).delete();
      return const Right(unit);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
