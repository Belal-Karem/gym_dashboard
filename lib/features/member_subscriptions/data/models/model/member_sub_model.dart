import 'package:power_gym/constants.dart';

class MemberSubscriptionModel {
  final String id;
  final String memberId;
  final String subscriptionId;

  final DateTime startDate;
  final DateTime endDate;

  final int remainingDays;
  final int attendance;
  final SubscriptionStatus status;
  final String? dateId;
  final String? dateIdAttendance;

  MemberSubscriptionModel({
    this.dateIdAttendance,
    required this.id,
    required this.memberId,
    required this.subscriptionId,
    required this.startDate,
    required this.endDate,
    required this.remainingDays,
    required this.attendance,
    required this.status,
    this.dateId,
  });

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'subscriptionId': subscriptionId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'dateId': dateId,
      'remainingDays': remainingDays,
      'attendance': attendance,
      'status': status.name,
      'dateIdAttendance': dateIdAttendance,
    };
  }

  factory MemberSubscriptionModel.fromJson(
    Map<String, dynamic> map,
    String docId,
  ) {
    return MemberSubscriptionModel(
      id: docId,
      memberId: map['memberId'],
      subscriptionId: map['subscriptionId'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      remainingDays: map['remainingDays'],
      attendance: map['attendance'],
      status: SubscriptionStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => SubscriptionStatus.expired,
      ),
      dateId: map['dateId'] as String?,
      dateIdAttendance: map['dateIdAttendance'] as String?,
    );
  }
  MemberSubscriptionModel copyWith({
    String? dateId,
    String? dateIdAttendance,
    DateTime? startDate,
    DateTime? endDate,
    int? remainingDays,
    int? attendance,
    SubscriptionStatus? status,
  }) {
    return MemberSubscriptionModel(
      id: id,
      memberId: memberId,
      subscriptionId: subscriptionId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dateId: dateId ?? this.dateId,
      remainingDays: remainingDays ?? this.remainingDays,
      attendance: attendance ?? this.attendance,
      status: status ?? this.status,
      dateIdAttendance: dateIdAttendance ?? this.dateIdAttendance,
    );
  }
}
