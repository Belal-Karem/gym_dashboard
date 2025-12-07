import 'package:dartz/dartz.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';

abstract class MemberSubscriptionsRepo {
  Future<Either<Failure, Unit>> addMemberSubscription(
    MemberSubscriptionModel subscription,
  );
  Future<Either<Failure, List<MemberSubscriptionModel>>>
  getSubscriptionsByMember(String memberId);
}
