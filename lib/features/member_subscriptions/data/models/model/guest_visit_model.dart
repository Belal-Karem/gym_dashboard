class GuestVisitModel {
  final String id;
  final String hostMemberId;
  final String subscriptionId;
  final String guestName;
  final String? guestPhone;
  final DateTime checkInTime;
  final String dateId;

  GuestVisitModel({
    required this.id,
    required this.hostMemberId,
    required this.subscriptionId,
    required this.guestName,
    this.guestPhone,
    required this.checkInTime,
    required this.dateId,
  });

  Map<String, dynamic> toJson() {
    return {
      'hostMemberId': hostMemberId,
      'subscriptionId': subscriptionId,
      'guestName': guestName,
      'guestPhone': guestPhone,
      'checkInTime': checkInTime.toIso8601String(),
      'dateId': dateId,
    };
  }

  factory GuestVisitModel.fromJson(String id, Map<String, dynamic> json) {
    return GuestVisitModel(
      id: id,
      hostMemberId: json['hostMemberId'],
      subscriptionId: json['subscriptionId'],
      guestName: json['guestName'],
      guestPhone: json['guestPhone'],
      checkInTime: DateTime.parse(json['checkInTime']),
      dateId: json['dateId'],
    );
  }
  GuestVisitModel copyWith({
    String? id,
    String? hostMemberId,
    String? subscriptionId,
    String? guestName,
    String? guestPhone,
    DateTime? checkInTime,
    String? dateId,
  }) {
    return GuestVisitModel(
      id: id ?? this.id,
      hostMemberId: hostMemberId ?? this.hostMemberId,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      guestName: guestName ?? this.guestName,
      guestPhone: guestPhone ?? this.guestPhone,
      checkInTime: checkInTime ?? this.checkInTime,
      dateId: dateId ?? this.dateId,
    );
  }
}
