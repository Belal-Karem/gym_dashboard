import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/core/errors/firebase_error_mapper.dart';
import 'package:power_gym/features/trainers/data/models/repo/trainer_repo.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';

class TrainerRepoImpl implements TrainerRepo {
  final CollectionReference trainerRef = FirebaseFirestore.instance.collection(
    ktrainerCollections,
  );

  @override
  Future<Either<Failure, Stream<List<TrainerModel>>>> getAllTrainers() async {
    try {
      final stream = trainerRef.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return TrainerModel.fromJson(
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
  Future<Either<Failure, Unit>> addTrainer(TrainerModel member) async {
    try {
      await trainerRef.doc(member.id).set(member.toJson());
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTrainer(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await trainerRef.doc(id).update(data);
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTrainer(String id) async {
    try {
      await trainerRef.doc(id).delete();
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }
}
