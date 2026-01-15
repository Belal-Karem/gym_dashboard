import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/core/errors/firebase_error_mapper.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo.dart';
import 'package:power_gym/features/plan_and_packages/data/models/plan_model/plan_model.dart';
import 'package:power_gym/features/plan_and_packages/data/models/repo/plan_repo.dart';
import 'package:power_gym/features/trainers/data/models/repo/trainer_repo.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';

class PlanRepoImpl implements PlanRepo {
  final FirebaseFirestore firestore;

  PlanRepoImpl(this.firestore);

  @override
  Future<Either<Failure, Stream<List<PlanModel>>>> getAllPlan() async {
    try {
      final stream = firestore
          .collection(kplanCollections)
          .snapshots()
          .asyncMap((snapshot) async {
            List<PlanModel> plans = [];

            for (var doc in snapshot.docs) {
              final data = doc.data();

              // ✅ Get Member
              final memberDoc = await firestore
                  .collection(kMemberCollections)
                  .doc(data['memberId'])
                  .get();

              // ✅ Get Trainer
              final trainerDoc = await firestore
                  .collection(ktrainerCollections)
                  .doc(data['trainerId'])
                  .get();

              if (memberDoc.exists && trainerDoc.exists) {
                final member = MemberModel.fromJson(
                  memberDoc.data() as Map<String, dynamic>,
                  memberDoc.id,
                );

                final trainer = TrainerModel.fromJson(
                  trainerDoc.data() as Map<String, dynamic>,
                  trainerDoc.id,
                );

                plans.add(PlanModel.fromJson(data, doc.id, member, trainer));
              }
            }

            return plans;
          });

      return Right(stream);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> addPlan(PlanModel plan) async {
    try {
      final docRef = firestore.collection(kplanCollections).doc();
      await docRef.set(plan.toJson());
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
      await firestore.collection(kplanCollections).doc(id).update(data);
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePlan(String id) async {
    try {
      await firestore.collection(kplanCollections).doc(id).delete();
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<bool> hasActivePrivatePlan(String memberId) async {
    try {
      final snapshot = await firestore
          .collection(kplanCollections)
          .where('memberId', isEqualTo: memberId)
          .where('private', isEqualTo: 'private')
          .where('status', isEqualTo: 'نشط')
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
