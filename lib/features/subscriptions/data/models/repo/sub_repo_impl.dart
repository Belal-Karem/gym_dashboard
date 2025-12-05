import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/core/errors/firebase_error_mapper.dart';
import 'package:power_gym/features/subscriptions/data/models/repo/sub_repo.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

class SubRepoImpl implements SubRepo {
  final CollectionReference subsRef = FirebaseFirestore.instance.collection(
    kSubCollections,
  );

  @override
  Future<Either<Failure, Stream<List<SubModel>>>> getAllSub() async {
    try {
      final stream = subsRef.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return SubModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
      });

      return Right(stream);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  // @override
  // Future<Either<Failure, Unit>> addSub(SubModel sub) async {
  //   try {
  //     await subsRef.doc(sub.id).set(sub.toJson());
  //     return const Right(unit);
  //   } catch (e) {
  //     return Left(handleFirebaseException(e));
  //   }
  // }

  Future<Either<Failure, Unit>> addSub(SubModel sub) async {
    try {
      final docRef = subsRef.doc();
      await docRef.set(sub.copyWith(id: docRef.id).toJson());

      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateSub(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await subsRef.doc(id).update(data);
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteSub(String id) async {
    try {
      await subsRef.doc(id).delete();
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }
}
