import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/core/errors/firebase_error_mapper.dart';
import 'package:power_gym/features/home/data/models/model/dash_board_model.dart';
import 'package:power_gym/features/home/data/models/repo/dash_board_repo.dart';

class DashBoardRepoImpl implements DashBoardRepo {
  final CollectionReference membersRef = FirebaseFirestore.instance.collection(
    kMemberCollections,
  );

  @override
  Future<Either<Failure, Stream<List<DashBoardModel>>>>
  getAllDashBoard() async {
    try {
      final stream = membersRef.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return DashBoardModel.fromJson(
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

  @override
  Future<Either<Failure, Unit>> updateDashBoard(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await membersRef.doc(id).update(data);
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }
}
