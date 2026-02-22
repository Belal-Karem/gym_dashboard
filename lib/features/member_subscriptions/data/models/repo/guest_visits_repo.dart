import 'package:dartz/dartz.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/guest_visit_model.dart';

abstract class GuestVisitsRepo {
  Future<Either<Failure, Unit>> addGuestVisit(GuestVisitModel visit);

  Future<Either<Failure, List<GuestVisitModel>>> getGuestVisitsByDate(
    String dateId,
  );

  Future<Either<Failure, List<GuestVisitModel>>> getGuestVisitsByMember(
    String memberId,
  );
}
