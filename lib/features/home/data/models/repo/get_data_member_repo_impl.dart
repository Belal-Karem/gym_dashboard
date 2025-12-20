import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/core/errors/firebase_error_mapper.dart';
import 'package:power_gym/features/home/data/models/repo/get_data_member_repo.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

class GetDataMemberRepoImpl implements GetDataMemberRepo {
  final CollectionReference membersRef = FirebaseFirestore.instance.collection(
    kMemberCollections,
  );

  @override
  Future<Either<Failure, Stream<List<MemberModel>>>> getDataMember() async {
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
      return Left(handleFirebaseException(e));
    }
  }
}
