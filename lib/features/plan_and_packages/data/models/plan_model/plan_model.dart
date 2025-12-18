import 'package:power_gym/constants.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';

class PlanModel {
  final String id;
  final MemberModel member;
  final TrainerModel trainer;
  final String session;
  final String status;
  final String price;
  final String attendance;
  final String duration;

  PlanModel({
    required this.id,
    required this.member,
    required this.trainer,
    required this.session,
    required this.status,
    required this.price,
    required this.attendance,
    required this.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      kmemberid: member.id, // مجرد ID
      ktrainerid: trainer.id, // مجرد ID
      ksession: session,
      kstatus: status,
      kprice: price,
      kattendance: attendance,
      kduration: duration,
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
      session: map[ksession] ?? '',
      status: map[kstatus] ?? '',
      price: map[kprice] ?? '',
      attendance: map[kattendance] ?? '',
      duration: map[kduration] ?? '',
    );
  }

  PlanModel copyWith({
    String? id,
    MemberModel? member,
    TrainerModel? trainer,
    String? invitation,
    String? type,
    String? status,
    String? price,
    String? maxAttendance,
    String? duration,
  }) {
    return PlanModel(
      id: id ?? this.id,
      member: member ?? this.member,
      trainer: trainer ?? this.trainer,
      session: invitation ?? this.session,
      status: status ?? this.status,
      price: price ?? this.price,
      attendance: type ?? this.attendance,
      duration: duration ?? this.duration,
    );
  }
}
