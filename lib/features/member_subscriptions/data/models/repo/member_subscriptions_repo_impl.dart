import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/core/errors/firebase_error_mapper.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/member_subscriptions_repo.dart';

class MemberSubscriptionsRepoImpl implements MemberSubscriptionsRepo {
  final CollectionReference subsRef = FirebaseFirestore.instance.collection(
    kmembersubscriptionsCollections,
  );

  @override
  Future<Either<Failure, Unit>> addMemberSubscription(
    MemberSubscriptionModel subscription,
  ) async {
    try {
      final dateId = _dateIdFromDateTime(subscription.startDate);

      await subsRef.add(subscription.copyWith(dateId: dateId).toJson());

      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, List<MemberSubscriptionModel>>>
  getSubscriptionsByMember(String memberId) async {
    try {
      final result = await subsRef
          .where('memberId', isEqualTo: memberId)
          .orderBy('startDate', descending: true)
          .get();

      final list = result.docs.map((doc) {
        return MemberSubscriptionModel.fromJson(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();

      return Right(list);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateMemberSubscription(
    MemberSubscriptionModel subscription,
  ) async {
    try {
      await subsRef.doc(subscription.id).update(subscription.toJson());

      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }
}

String _dateIdFromDateTime(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}
