import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/core/errors/firebase_error_mapper.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/plans_repo.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

class PlansRepoImpl implements PlansRepo {
  final CollectionReference plansRef = FirebaseFirestore.instance.collection(
    kSubCollections,
  );

  @override
  Future<Either<Failure, SubModel>> getPlanById(String id) async {
    try {
      final doc = await plansRef.doc(id).get();

      return Right(
        SubModel.fromJson(doc.data() as Map<String, dynamic>, doc.id),
      );
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }
}
