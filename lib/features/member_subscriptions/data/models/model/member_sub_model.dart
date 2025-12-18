class MemberSubscriptionModel {
  final String memberId;
  final String subId;
  final DateTime startDate;
  final DateTime endDate;
  final String status; // active / expired / frozen

  MemberSubscriptionModel({
    required this.memberId,
    required this.subId,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    "memberId": memberId,
    "subId": subId,
    "startDate": startDate.toIso8601String(),
    "endDate": endDate.toIso8601String(),
    "status": status,
  };

  factory MemberSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return MemberSubscriptionModel(
      memberId: json['memberId'],
      subId: json['subId'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'] ?? 'active',
    );
  }

  int get remainingDays {
    final today = DateTime.now();
    return endDate.difference(today).inDays;
  }

  bool get isExpired => remainingDays <= 0;
}
