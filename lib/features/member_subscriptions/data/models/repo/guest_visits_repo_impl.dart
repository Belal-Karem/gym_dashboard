import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/core/errors/firebase_error_mapper.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/guest_visit_model.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/guest_visits_repo.dart';

class GuestVisitsRepoImpl implements GuestVisitsRepo {
  final FirebaseFirestore firestore;

  GuestVisitsRepoImpl(this.firestore);

  CollectionReference get _ref => firestore.collection(kguestvisitsCollections);
  @override
  Future<Either<Failure, Unit>> addGuestVisit(GuestVisitModel visit) async {
    try {
      final doc = _ref.doc();

      final visitWithId = visit.copyWith(id: doc.id);

      await doc.set(visitWithId.toJson());

      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, List<GuestVisitModel>>> getGuestVisitsByDate(
    String dateId,
  ) async {
    try {
      final snapshot = await _ref.where('dateId', isEqualTo: dateId).get();

      final list = snapshot.docs
          .map(
            (d) => GuestVisitModel.fromJson(
              d.id,
              d.data() as Map<String, dynamic>,
            ),
          )
          .toList();

      return Right(list);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, List<GuestVisitModel>>> getGuestVisitsByMember(
    String memberId,
  ) async {
    try {
      final snapshot = await _ref
          .where('hostMemberId', isEqualTo: memberId)
          .get();

      final list = snapshot.docs
          .map(
            (d) => GuestVisitModel.fromJson(
              d.id,
              d.data() as Map<String, dynamic>,
            ),
          )
          .toList();

      return Right(list);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }
}
