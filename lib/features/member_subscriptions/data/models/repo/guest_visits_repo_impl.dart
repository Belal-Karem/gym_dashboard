import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/core/errors/firebase_error_mapper.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/guest_visit_model.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/guest_visits_repo.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

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

  Future<void> markAttendance(
    MemberModel member,
    MemberSubscriptionModel subscription,
    String guestName,
    String? guestPhone,
  ) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final dateId = today.toIso8601String().split('T').first;

    final docRef = firestore
        .collection('attendance')
        .doc(dateId)
        .collection('members')
        .doc(subscription.memberId);

    await docRef.set({
      'id': member.id,
      'memberId': 'دعوه من: ${member.name}',
      'subscriptionId': subscription.id,
      'attendanceCount': 0,
      'name': guestName,
      'phone': guestPhone,
      'status': subscription.status.name,
      'isGuest': true,
      'time': FieldValue.serverTimestamp(),
    });
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
