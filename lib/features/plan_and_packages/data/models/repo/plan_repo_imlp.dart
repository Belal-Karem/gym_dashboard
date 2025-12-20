import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/core/errors/firebase_error_mapper.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/plan_and_packages/data/models/plan_model/plan_model.dart';
import 'package:power_gym/features/plan_and_packages/data/models/repo/plan_repo.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';

class PlanRepoImpl implements PlanRepo {
  final CollectionReference plansRef = FirebaseFirestore.instance.collection(
    kplanCollections,
  );
  final FirebaseFirestore firestore;

  PlanRepoImpl(this.firestore);

  @override
  Future<Either<Failure, Stream<List<PlanModel>>>> getAllPlan() async {
    try {
      final stream = plansRef.snapshots().asyncMap((snapshot) async {
        List<PlanModel> plans = [];

        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          final memberDoc = await FirebaseFirestore.instance
              .collection(kMemberCollections)
              .doc(data[kmemberid])
              .get();
          if (!memberDoc.exists || memberDoc.data() == null) {
            continue;
          }

          final member = MemberModel.fromJson(memberDoc.data()!, memberDoc.id);

          final trainerDoc = await FirebaseFirestore.instance
              .collection(ktrainerCollections)
              .doc(data[ktrainerid])
              .get();
          if (!trainerDoc.exists || trainerDoc.data() == null) {
            continue;
          }

          final trainer = TrainerModel.fromJson(
            trainerDoc.data()!,
            trainerDoc.id,
          );

          plans.add(PlanModel.fromJson(data, doc.id, member, trainer));
        }

        return plans;
      });

      return Right(stream);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

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

  @override
  Future<bool> hasActivePrivatePlan(String id) async {
    final query = await firestore
        .collection(kplanCollections)
        .where('memberId', isEqualTo: id)
        .where('private', isEqualTo: 'private')
        .where('status', isEqualTo: 'نشط')
        .limit(1)
        .get();

    return query.docs.isNotEmpty;
  }
}
