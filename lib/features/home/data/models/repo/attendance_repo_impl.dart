import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:power_gym/features/home/data/models/model/recent_member_model.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

class AttendanceRepoImpl implements AttendanceRepo {
  final FirebaseFirestore firestore;

  AttendanceRepoImpl(this.firestore);

  @override
  Future<void> markAttendance(
    MemberModel member,
    MemberSubscriptionModel subscription,
  ) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final dateId = today.toIso8601String().split('T').first;

    final docRef = firestore
        .collection('attendance')
        .doc(dateId)
        .collection('members')
        .doc(subscription.memberId);

    final doc = await docRef.get();

    if (doc.exists) {
      throw Exception('العضو مسجل بالفعل');
    }

    await docRef.set({
      'id': member.id,
      'memberId': member.memberId,
      'subscriptionId': subscription.id,
      'attendanceCount': subscription.attendance + 1,
      'name': member.name,
      'phone': member.phone,
      'status': subscription.status.name,
      'time': FieldValue.serverTimestamp(),
    });
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