import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:power_gym/features/home/data/models/model/recent_member_model.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

class AttendanceRepoImpl implements AttendanceRepo {
  final FirebaseFirestore firestore;

  AttendanceRepoImpl(this.firestore);

  // @override
  // Future<void> markAttendance(MemberModel member) async {
  //   final today = DateUtils.dateOnly(DateTime.now());
  //   final dateId = today.toIso8601String().split('T').first;

  //   final docRef = firestore
  //       .collection('attendance')
  //       .doc(dateId)
  //       .collection('members')
  //       .doc(member.id);

  //   final doc = await docRef.get();

  //   if (doc.exists) {
  //     throw Exception('العضو مسجل بالفعل');
  //   }

  //   await docRef.set({
  //     'id': member.id,
  //     'memberId': member.memberId,
  //     'name': member.name,
  //     'phone': member.phone,
  //     'attendanceCount': int.parse(member.attendance) + 1,
  //     'status': member.status,
  //     'time': FieldValue.serverTimestamp(),
  //   });

  // }

  @override
  Future<void> markAttendance(MemberModel member) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final dateId = today.toIso8601String().split('T').first;

    final docRef = firestore
        .collection('attendance')
        .doc(dateId)
        .collection('members')
        .doc(member.id);

    final doc = await docRef.get();

    if (doc.exists) {
      final currentCount = (doc.data()?['attendanceCount'] ?? 0) as int;
      await docRef.update({
        'attendanceCount': currentCount + 1,
        'time': FieldValue.serverTimestamp(),
      });
    } else {
      await docRef.set({
        'id': member.id,
        'memberId': member.memberId,
        'startDate': member.startdata,
        'endDate': member.endDate,
        'memberName': member.name,
        'phone': member.phone,
        'attendanceCount': int.parse(member.attendance) + 1,
        'status': member.status,
        'time': FieldValue.serverTimestamp(),
        'note': member.note,
      });
    }
  }

  @override
  Stream<int> getTodayAttendanceCount() {
    final today = DateUtils.dateOnly(DateTime.now());
    final dateId = today.toIso8601String().split('T').first;

    return firestore
        .collection('attendance')
        .doc(dateId)
        .collection('members')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  @override
  Stream<List<RecentMemberModel>> getTodayRecentMembers() {
    final today = DateUtils.dateOnly(DateTime.now());
    final dateId = today.toIso8601String().split('T').first;

    return firestore
        .collection('attendance')
        .doc(dateId)
        .collection('members')
        .orderBy('time', descending: true)
        .limit(10)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RecentMemberModel.fromJson(doc.data()))
              .toList(),
        );
  }
}
