class MemberSubscriptionModel {
  final String memberId;
  final String subId;
  final String startDate;
  final String endDate;
  final int remainingDays;
  final String? dateId;
  final bool? isRenewal;
  final String status; // active / expired / frozen

  MemberSubscriptionModel({
    required this.remainingDays,
    required this.memberId,
    required this.subId,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.dateId,
    this.isRenewal,
  });

  factory MemberSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return MemberSubscriptionModel(
      memberId: json['memberId'] ?? '',
      subId: json['subId'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      remainingDays: json['remainingDays'],
      status: json['status'] ?? 'active',
      dateId: json['dateId'] ?? '',
      isRenewal: json['isRenewal'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "memberId": memberId,
    "subId": subId,
    "startDate": startDate,
    "endDate": endDate,
    "status": status,
    "remainingDays": remainingDays,
    "dateId": dateId,
    "isRenewal": isRenewal,
  };

  MemberSubscriptionModel copyWith({
    String? memberId,
    String? subId,
    String? startDate,
    String? endDate,
    int? remainingDays,
    String? status,
    String? dateId,
    bool? isRenewal,
  }) {
    return MemberSubscriptionModel(
      memberId: memberId ?? this.memberId,
      subId: subId ?? this.subId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      remainingDays: remainingDays ?? this.remainingDays,
      status: status ?? this.status,
      dateId: dateId ?? this.dateId,
      isRenewal: isRenewal ?? this.isRenewal,
    );
  }
}
