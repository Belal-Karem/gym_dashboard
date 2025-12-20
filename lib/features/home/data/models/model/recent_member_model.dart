import 'package:cloud_firestore/cloud_firestore.dart';

class RecentMemberModel {
  final String memberId;
  final String name;
  final String phone;
  final DateTime time;
  final String status;
  final int attendanceCount;

  RecentMemberModel({
    required this.memberId,
    required this.name,
    required this.time,
    required this.phone,
    required this.attendanceCount,
    required this.status,
  });

  factory RecentMemberModel.fromJson(Map<String, dynamic> json) {
    return RecentMemberModel(
      memberId: json['memberId'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      time: (json['time'] as Timestamp).toDate(),
      attendanceCount: json['attendanceCount'] as int,
      status: json['status'] as String,
    );
  }
}
