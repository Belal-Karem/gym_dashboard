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

  //   final attendanc = int.parse(member.attendance) + 1;
  //   await docRef.set({
  //     'id': member.id,
  //     'memberId': member.memberId,
  //     'name': member.name,
  //     'phone': member.phone,
  //     'attendanceCount': attendanc,
  //     'status': member.status,
  //     'time': FieldValue.serverTimestamp(),
  //   });

  // }

  @override
  Future<void> markAttendance(MemberModel member) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final dateId = today.toIso8601String().split('T').first;

    final attendanceRef = firestore
        .collection('attendance')
        .doc(dateId)
        .collection('members')
        .doc(member.id);

    final memberRef = firestore.collection('member').doc(member.id);

    final attendanceDoc = await attendanceRef.get();

    if (attendanceDoc.exists) {
      throw Exception('العضو مسجل بالفعل');
    }

    await attendanceRef.set({
      'id': member.id,
      'memberId': member.memberId,
      'name': member.name,
      'phone': member.phone,
      'attendanceCount': member.attendance + 1,
      'status': member.status,
      'time': FieldValue.serverTimestamp(),
    });

    // 2️⃣ زوّد عدد الحضور في بيانات العضو
    await memberRef.update({'attendance': FieldValue.increment(1)});
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
