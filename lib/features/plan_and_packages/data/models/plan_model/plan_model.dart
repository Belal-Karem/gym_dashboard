import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';

class PlanModel {
  final String id;
  final MemberModel member;
  final TrainerModel trainer;
  final String session;
  final String method;
  final String price;
  final String attendance;
  final String duration;
  final String status;
  final String private;

  PlanModel({
    required this.id,
    required this.member,
    required this.trainer,
    required this.session,
    required this.method,
    required this.price,
    required this.attendance,
    required this.duration,
    required this.status,
    required this.private,
  });

  Map<String, dynamic> toJson() {
    return {
      'memberId': member.id,
      'trainerId': trainer.id,
      'session': session,
      'method': method,
      'price': price,
      'attendance': attendance,
      'duration': duration,
      'status': status,
      'private': private,
    };
  }

  factory PlanModel.fromJson(
    Map<String, dynamic> map,
    String docId,
    MemberModel member,
    TrainerModel trainer,
  ) {
    return PlanModel(
      id: docId,
      member: member,
      trainer: trainer,
      session: map['session'] ?? '',
      method: map['method'] ?? '',
      price: map['price'] ?? '',
      attendance: map['attendance'] ?? '0',
      duration: map['duration'] ?? '',
      status: map['status'] ?? 'نشط',
      private: map['private'] ?? 'private',
    );
  }

  PlanModel copyWith({
    String? id,
    MemberModel? member,
    TrainerModel? trainer,
    String? session,
    String? method,
    String? price,
    String? attendance,
    String? duration,
    String? status,
    String? private,
  }) {
    return PlanModel(
      id: id ?? this.id,
      member: member ?? this.member,
      trainer: trainer ?? this.trainer,
      session: session ?? this.session,
      method: method ?? this.method,
      price: price ?? this.price,
      attendance: attendance ?? this.attendance,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      private: private ?? this.private,
    );
  }
}
