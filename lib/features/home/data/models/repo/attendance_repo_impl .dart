import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/features/home/data/models/model/dash_board_model.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';

class AttendanceRepoImpl implements AttendanceRepo {
  final FirebaseFirestore firestore;

  AttendanceRepoImpl(this.firestore);

  @override
  Future<Either<Failure, Unit>> markAttendance(
    String id,
    String memberId,
    String memberName,
  ) async {
    try {
      final today = DateUtils.dateOnly(DateTime.now());
      final dateId = today.toIso8601String().split('T').first;

      final ref = firestore
          .collection('attendance')
          .doc(dateId)
          .collection('records')
          .doc(id);

      await ref.set({
        'id': id,
        'memberId': memberId,
        'memberName': memberName,
        'time': FieldValue.serverTimestamp(),
      });

      return const Right(unit);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Stream<List<String>> getTodayAttendanceIds() {
    final today = DateUtils.dateOnly(DateTime.now());
    final dateId = today.toIso8601String().split('T').first;

    return firestore
        .collection('attendance')
        .doc(dateId)
        .collection('records')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => doc['memberId'] as String).toList(),
        );
  }
}
