import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/home/data/models/model/recent_member_model.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

class AttendanceRepoImpl implements AttendanceRepo {
  final FirebaseFirestore firestore;

  AttendanceRepoImpl(this.firestore);

  @override
  Future<void> markAttendance(
    MemberSubscriptionModel sub,
    SubModel plan,
  ) async {
    // ❌ اشتراك منتهي
    if (sub.status != 'active') {
      throw Exception('الاشتراك غير نشط');
    }

    // ❌ تجاوز الحد الأقصى
    if (sub.attendance >= plan.maxAttendance) {
      throw Exception('تم الوصول للحد الأقصى للحضور');
    }

    final today = DateUtils.dateOnly(DateTime.now());
    final dateId = DateFormat('yyyy-MM-dd').format(today);

    final attendanceRef = firestore
        .collection('attendance')
        .doc(dateId)
        .collection('subscriptions')
        .doc(sub.id);

    final attendanceDoc = await attendanceRef.get();

    if (attendanceDoc.exists) {
      throw Exception('تم تسجيل الحضور اليوم بالفعل');
    }

    // 1️⃣ تسجيل الحضور
    await attendanceRef.set({
      'subscriptionId': sub.id,
      'memberId': sub.memberId,
      'time': FieldValue.serverTimestamp(),
    });

    // 2️⃣ تحديث الاشتراك
    await firestore
        .collection(kmembersubscriptionsCollections)
        .doc(sub.id)
        .update({'attendance': FieldValue.increment(1)});
  }

  @override
  Stream<int> getTodayAttendanceCount() {
    final today = DateUtils.dateOnly(DateTime.now());
    final dateId = DateFormat('yyyy-MM-dd').format(today);

    return firestore
        .collection('attendance')
        .doc(dateId)
        .collection('subscriptions')
        .snapshots()
        .map((s) => s.docs.length);
  }

  @override
  Stream<List<RecentMemberModel>> getTodayRecentMembers() {
    final today = DateUtils.dateOnly(DateTime.now());
    final dateId = DateFormat('yyyy-MM-dd').format(today);

    return firestore
        .collection('attendance')
        .doc(dateId)
        .collection('subscriptions')
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