class MemberSubscriptionModel {
  final String memberId;
  final String subId;
  final String startDate;
  final String endDate;
  final String status; // active / expired / frozen

  MemberSubscriptionModel({
    required this.memberId,
    required this.subId,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory MemberSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return MemberSubscriptionModel(
      memberId: json['memberId'] ?? '',
      subId: json['subId'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      status: json['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toJson() => {
    "memberId": memberId,
    "subId": subId,
    "startDate": startDate,
    "endDate": endDate,
    "status": status,
  };
}
