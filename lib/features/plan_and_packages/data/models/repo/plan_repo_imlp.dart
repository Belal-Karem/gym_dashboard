import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/core/errors/firebase_error_mapper.dart';
import 'package:power_gym/features/plan_and_packages/data/models/plan_model/plan_model.dart';
import 'package:power_gym/features/plan_and_packages/data/models/repo/plan_repo.dart';

class PlanRepoImpl implements PlanRepo {
  final CollectionReference plansRef = FirebaseFirestore.instance.collection(
    kplanCollections,
  );

  @override
  Future<Either<Failure, Stream<List<PlanModel>>>> getAllPlan() async {
    try {
      final stream = plansRef.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return PlanModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
      });

      return Right(stream);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  // @override
  // Future<Either<Failure, Unit>> addPlan(PlanModel Plan) async {
  //   try {
  //     await PlansRef.doc(Plan.id).set(Plan.toJson());
  //     return const Right(unit);
  //   } catch (e) {
  //     return Left(handleFirebaseException(e));
  //   }
  // }

  Future<Either<Failure, Unit>> addPlan(PlanModel Plan) async {
    try {
      final docRef = plansRef.doc();
      await docRef.set(Plan.copyWith(id: docRef.id).toJson());

      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePlan(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await plansRef.doc(id).update(data);
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePlan(String id) async {
    try {
      await plansRef.doc(id).delete();
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }
}
