import 'package:power_gym/constants.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/trainers/data/models/trainer_model/trainer_model.dart';

class PlanModel {
  final String id;
  final MemberModel memberid;
  final TrainerModel trainerid;
  final String session;
  final String status;
  final String price;
  final String attendance;

  PlanModel({
    required this.id,
    required this.memberid,
    required this.trainerid,
    required this.session,
    required this.status,
    required this.price,
    required this.attendance,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      kmemberid: memberid, //memberId'
      ktrainerid: trainerid,
      ksession: session,
      kstatus: status,
      kprice: price,
      kattendance: attendance,
    };
  }

  factory PlanModel.fromJson(Map<String, dynamic> map, String docId) {
    return PlanModel(
      id: docId,
      memberid: map[kmemberid] ?? '',
      trainerid: map[ktrainerid] ?? '',
      session: map[ksession] ?? '',
      status: map[kstatus] ?? '',
      price: map[kprice] ?? '',
      attendance: map[kattendance] ?? '',
    );
  }

  PlanModel copyWith({
    String? id,
    MemberModel? memberid,
    TrainerModel? trainerid,
    String? invitation,
    String? type,
    String? status,
    String? price,
    String? maxAttendance,
  }) {
    return PlanModel(
      id: id ?? this.id,
      memberid: memberid ?? this.memberid,
      trainerid: trainerid ?? this.trainerid,
      session: invitation ?? this.session,
      status: status ?? this.status,
      price: price ?? this.price,
      attendance: type ?? this.attendance,
    );
  }
}
