import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';

class DashBoardModel {
  final String id; // Firestore doc id
  final String memberId; // Logical member id
  final String name;
  final String phone;
  final DateTime joinDate;
  final DateTime startDate;
  final int? attendance;
  final int? freeze;
  final int? invites;
  final DateTime affiliationDate;
  final String status; // active / expired / frozen
  final String note;
  final MemberSubscriptionModel? subscription;

  const DashBoardModel({
    required this.id,
    required this.memberId,
    required this.name,
    required this.phone,
    required this.startDate,
    required this.affiliationDate,
    required this.attendance,
    required this.status,
    required this.note,
    this.subscription,
    required this.joinDate,
    this.freeze,
    this.invites,
  });

  factory DashBoardModel.fromJson(Map<String, dynamic> json, String docId) {
    return DashBoardModel(
      id: docId,
      memberId: json[kmemberid] ?? '',
      name: json[kname] ?? '',
      phone: json[kPhone] ?? '',
      startDate: safeParseDate(json[kStartdate]),
      affiliationDate: safeParseDate(json[kaffiliationdate]),
      attendance: json[kattendance] ?? '',
      status: json['status'] ?? 'active',
      note: json[knote] ?? '',
      subscription: json['subscription'],
      // != null
      //     ? MemberSubscriptionModel.fromJson(json['subscription'])
      //     : null,
      joinDate: safeParseDate(json['joinDate']),
      freeze: json['freeze'] ?? 0,
      invites: json['invites'] ?? 0,
    );
  }

  /// View-only (مش أساسي للـ Dashboard بس موجود لو احتجته)
  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'name': name,
      'phone': phone,
      'startDate': startDate.toIso8601String(),
      'affiliationDate': affiliationDate.toIso8601String(),
      'attendance': attendance,
      'status': status,
      'note': note,
      'joinDate': joinDate.toIso8601String(),
      'invites': invites,
      'freeze': freeze,
    };
  }

  DashBoardModel copyWith({
    String? id,
    String? memberId,
    String? name,
    String? phone,
    DateTime? startDate,
    DateTime? affiliationDate,
    int? attendance,
    String? status,
    String? note,
    DateTime? joinDate,
    int? invites,
    int? freeze,
    MemberSubscriptionModel? subscription,
  }) {
    return DashBoardModel(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      startDate: startDate ?? this.startDate,
      affiliationDate: affiliationDate ?? this.affiliationDate,
      attendance: attendance ?? this.attendance,
      status: status ?? this.status,
      note: note ?? this.note,
      subscription: subscription ?? this.subscription,
      joinDate: joinDate ?? this.joinDate,
      invites: invites ?? this.invites,
      freeze: freeze ?? this.freeze,
    );
  }
}

DateTime safeParseDate(dynamic value) {
  if (value == null) return DateTime.now();

  if (value is Timestamp) return value.toDate();

  if (value is String) {
    return DateTime.tryParse(value) ?? DateTime.now();
  }

  return DateTime.now();
}
