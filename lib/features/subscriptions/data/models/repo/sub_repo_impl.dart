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
          final sub = SubModel.fromJson(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );

          // حساب duration بالأيام (لو محتاجه)
          final durationDays = sub.durationDays;

          return sub.copyWith(id: doc.id, durationDays: durationDays);
        }).toList();
      });

      return Right(stream);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
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
      // ✅ تحقق قبل الحذف لو في اشتراكات نشطة
      final subsCount = await FirebaseFirestore.instance
          .collection(kmembersubscriptionsCollections)
          .where('subId', isEqualTo: id)
          .get();

      if (subsCount.docs.isNotEmpty) {
        throw Exception('لا يمكن حذف الاشتراك لانه مستخدم حالياً');
      }

      await subsRef.doc(id).delete();
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
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