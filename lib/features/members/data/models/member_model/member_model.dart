import 'package:power_gym/constants.dart';

class MemberModel {
  final String id;
  final String memberId;
  final String name;
  final String phone;
  final String startdata;
  final String attendance;
  final String status;
  final String note;
  final String gender;
  final String endDate;
  final String remainingDays;
  final String affiliationdate;

  MemberModel({
    required this.id,
    required this.memberId,
    required this.name,
    required this.phone,
    required this.startdata,
    required this.attendance,
    required this.status,
    required this.note,
    required this.gender,
    required this.endDate,
    required this.remainingDays,
    required this.affiliationdate,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'startdata': startdata,
      'attendance': attendance,
      'status': status,
      'note': note,
      'gender': gender,
      'memberId': memberId,
      'affiliationdate': affiliationdate,
      'remainingDays': remainingDays,
      'endDate': endDate,
    };
  }

  factory MemberModel.fromJson(Map<String, dynamic> map, String docId) {
    return MemberModel(
      id: docId,
      affiliationdate: map[kaffiliationdate] ?? '',
      name: map[kname] ?? '',
      phone: map[kPhone] ?? '',
      startdata: map[kStartdate] ?? '',
      attendance: map[kattendance] ?? '',
      status: map['status'] ?? '',
      note: map[knote] ?? '',
      gender: map[kgender] ?? '',
      memberId: map[kmemberid] ?? '',
      endDate: map['endDate'] ?? '',
      remainingDays: map['remainingDays'] ?? '',
    );
  }

  MemberModel copyWith({
    String? id,
    String? memberId, // صححنا الاسم
    String? name,
    String? phone,
    String? startdata,
    String? enddata,
    String? attendance,
    String? status,
    String? gender,
    String? note,
    String? affiliationdate,
    String? remainingdays,
  }) {
    return MemberModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      startdata: startdata ?? this.startdata,
      affiliationdate: affiliationdate ?? this.affiliationdate,
      attendance: attendance ?? this.attendance,
      status: status ?? this.status,
      note: note ?? this.note,
      gender: gender ?? this.gender,
      memberId: memberId ?? this.memberId,
      endDate: enddata ?? this.endDate,
      remainingDays: remainingdays ?? this.remainingDays,
    );
  }
}
