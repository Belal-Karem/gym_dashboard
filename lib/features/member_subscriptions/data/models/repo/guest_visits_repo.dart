import 'package:dartz/dartz.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/guest_visit_model.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

abstract class GuestVisitsRepo {
  Future<Either<Failure, Unit>> addGuestVisit(GuestVisitModel visit);

  Future<Either<Failure, List<GuestVisitModel>>> getGuestVisitsByDate(
    String dateId,
  );

  Future<Either<Failure, List<GuestVisitModel>>> getGuestVisitsByMember(
    String memberId,
  );
  Future<void> markAttendance(
    MemberModel member,
    MemberSubscriptionModel subscription,
    String guestName,
    String? guestPhone,
  );
}
