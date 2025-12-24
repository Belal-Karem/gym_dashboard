import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
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
      // await subsRef
      //     .doc('${subscription.memberId}_${subscription.subId}')
      //     .set(subscription.toJson());

      final dateId = _extractDateIdFromString(subscription.startDate);

      await subsRef
          .doc('${subscription.memberId}_${subscription.subId}')
          .set(subscription.copyWith(dateId: dateId).toJson());
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, List<MemberSubscriptionModel>>>
  getSubscriptionsByMember(String memberId) async {
    try {
      final result = await subsRef.where('memberId', isEqualTo: memberId).get();
      final list = result.docs
          .map(
            (doc) => MemberSubscriptionModel.fromJson(
              doc.data() as Map<String, dynamic>,
            ),
          )
          .toList();
      return Right(list);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }
}

String _extractDateIdFromString(String date) {
  // لو ISO DateTime
  if (date.contains('T')) {
    return date.split('T').first;
  }

  // لو ISO Date فقط
  return date;
}
