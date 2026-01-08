import 'package:power_gym/constants.dart';

class SubModel {
  final String id;
  final int durationDays;
  final int freezeDays;
  final int invitationCount;
  final int maxAttendance;
  final double price;
  final String type;
  final String status;

  SubModel({
    required this.id,
    required this.durationDays,
    required this.freezeDays,
    required this.invitationCount,
    required this.maxAttendance,
    required this.price,
    required this.type,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'durationDays': durationDays,
      'freezeDays': freezeDays,
      'invitationCount': invitationCount,
      'maxAttendance': maxAttendance,
      'price': price,
      'type': type,
      'status': status,
    };
  }

  factory SubModel.fromJson(Map<String, dynamic> map, String docId) {
    return SubModel(
      id: docId,
      durationDays: (map['durationDays'] ?? 0) as int,
      freezeDays: (map['freezeDays'] ?? 0) as int,
      invitationCount: (map['invitationCount'] ?? 0) as int,
      maxAttendance: (map['maxAttendance'] ?? 0) as int,
      price: (map['price'] ?? 0).toDouble(),
      type: map['type'] ?? '',
      status: map['status'] ?? 'active',
    );
  }
  SubModel copyWith({
    String? id,
    int? durationDays,
    int? freezeDays,
    int? invitationCount,
    int? maxAttendance,
    double? price,
    String? type,
    String? status,
  }) {
    return SubModel(
      id: id ?? this.id,
      durationDays: durationDays ?? this.durationDays,
      freezeDays: freezeDays ?? this.freezeDays,
      invitationCount: invitationCount ?? this.invitationCount,
      maxAttendance: maxAttendance ?? this.maxAttendance,
      price: price ?? this.price,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }
}
