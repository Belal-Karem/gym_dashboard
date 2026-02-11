import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';

class PrivateModel {
  final String id;
  final MemberModel member;
  final TrainerModel trainer;

  final int totalSessions;
  final int usedSessions;
  final DateTime endDate;
  final DateTime startDate;

  final String method;
  final double paid;
  final String duration;
  final String status;
  final String private;
  final bool isActive;

  PrivateModel({
    required this.totalSessions,
    required this.usedSessions,
    required this.endDate,
    required this.isActive,
    required this.id,
    required this.member,
    required this.trainer,
    required this.method,
    required this.paid,
    required this.duration,
    required this.status,
    required this.private,
    required this.startDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'memberId': member.id,
      'trainerId': trainer.id,
      'method': method,
      'paid': paid,
      'totalSessions': totalSessions,
      'usedSessions': usedSessions,
      'endDate': Timestamp.fromDate(endDate),
      'duration': duration,
      'status': status,
      'private': private,
      'isActive': isActive,
      'type': 'private',
      'startDate': Timestamp.fromDate(startDate),
    };
  }

  factory PrivateModel.fromJson(
    Map<String, dynamic> map,
    String docId,
    MemberModel member,
    TrainerModel trainer,
  ) {
    return PrivateModel(
      id: docId,
      member: member,
      trainer: trainer,
      totalSessions: map['totalSessions'] ?? 0,
      usedSessions: map['usedSessions'] ?? 0,
      endDate: (map['endDate'] as Timestamp).toDate(),
      method: map['method'] ?? '',
      paid: map['paid'] ?? '',
      duration: map['duration'] ?? '',
      status: map['status'] ?? 'نشط',
      private: map['private'] ?? 'private',
      isActive: map['isActive'] ?? true,
      startDate: (map['startDate'] as Timestamp).toDate(),
    );
  }

  PrivateModel copyWith({
    String? id,
    MemberModel? member,
    TrainerModel? trainer,
    String? session,
    String? method,
    double? paid,
    String? attendance,
    String? duration,
    String? status,
    String? private,
    int? usedSessions,
    bool? isActive,
  }) {
    return PrivateModel(
      id: id ?? this.id,
      member: member ?? this.member,
      trainer: trainer ?? this.trainer,
      method: method ?? this.method,
      paid: paid ?? this.paid,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      private: private ?? this.private,
      totalSessions: totalSessions,
      usedSessions: usedSessions ?? this.usedSessions,
      endDate: endDate,
      isActive: isActive ?? this.isActive,
      startDate: startDate,
    );
  }
}
