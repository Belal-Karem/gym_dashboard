import 'package:power_gym/constants.dart';

class MemberSubscriptionModel {
  final String id;
  final String memberId;
  final String subscriptionId;

  final DateTime startDate;
  final DateTime endDate;
  final DateTime actionDate;
  final bool isRenewal;

  final int remainingDays;
  final int attendance;
  final SubscriptionStatus status;
  final String? dateId;
  final String dateIdForReport;
  final String? dateIdAttendance;

  MemberSubscriptionModel({
    this.dateIdAttendance,
    required this.id,
    required this.memberId,
    required this.subscriptionId,
    required this.startDate,
    required this.actionDate,
    required this.isRenewal,
    required this.endDate,
    required this.remainingDays,
    required this.attendance,
    required this.status,
    this.dateId,
    required this.dateIdForReport,
  });

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'subscriptionId': subscriptionId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'actionDate': actionDate.toIso8601String(),
      'isRenewal': isRenewal,
      'dateId': dateId,
      'remainingDays': remainingDays,
      'attendance': attendance,
      'status': status.name,
      'dateIdAttendance': dateIdAttendance,
      'dateIdForReport': dateIdForReport,
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
      actionDate: DateTime.parse(map['actionDate']),
      isRenewal: map['isRenewal'] ?? false,
      remainingDays: map['remainingDays'],
      attendance: map['attendance'],
      status: SubscriptionStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => SubscriptionStatus.expired,
      ),
      dateId: map['dateId'] as String?,
      dateIdAttendance: map['dateIdAttendance'] as String?,
      dateIdForReport: map['dateIdForReport'] as String,
    );
  }
  MemberSubscriptionModel copyWith({
    String? dateId,
    String? subscriptionId,
    String? dateIdAttendance,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? actionDate,
    bool? isRenewal,
    int? remainingDays,
    int? attendance,
    SubscriptionStatus? status,
    String? dateIdForReport,
  }) {
    return MemberSubscriptionModel(
      id: id,
      memberId: memberId,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      actionDate: actionDate ?? this.actionDate,
      isRenewal: isRenewal ?? this.isRenewal,
      dateId: dateId ?? this.dateId,
      remainingDays: remainingDays ?? this.remainingDays,
      attendance: attendance ?? this.attendance,
      status: status ?? this.status,
      dateIdAttendance: dateIdAttendance ?? this.dateIdAttendance,
      dateIdForReport: dateIdForReport ?? this.dateIdForReport,
    );
  }
}
