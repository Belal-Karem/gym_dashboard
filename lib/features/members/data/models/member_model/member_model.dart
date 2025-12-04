import 'package:power_gym/constants.dart';

class MemberModel {
  final String id;
  final String name;
  final String phone;
  final String startdata;
  final String enddata;
  final String attendance;
  final String absence;
  final String status;
  final String note;
  final String gender;

  MemberModel({
    required this.gender,
    required this.note,
    required this.id,
    required this.name,
    required this.phone,
    required this.startdata,
    required this.enddata,
    required this.attendance,
    required this.absence,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'startdata': startdata,
      'enddata': enddata,
      'attendance': attendance,
      'absence': absence,
      'status': status,
      'note': note,
      'gender': gender,
    };
  }

  factory MemberModel.fromJson(Map<String, dynamic> map, String docId) {
    return MemberModel(
      id: docId,
      name: map[kname] ?? '',
      phone: map[kPhone] ?? '',
      startdata: map[kStartdate] ?? '',
      enddata: map[kenddate] ?? '',
      attendance: map[kattendance] ?? '',
      absence: map[kabsence] ?? '',
      status: map['status'] ?? '',
      note: map[knote] ?? '',
      gender: map[kgender] ?? '',
    );
  }

  MemberModel copyWith({
    String? id,
    String? memberid,
    String? name,
    String? phone,
    String? startdata,
    String? enddata,
    String? attendance,
    String? absence,
    String? status,
    String? gender,
    String? note,
  }) {
    return MemberModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      startdata: startdata ?? this.startdata,
      enddata: enddata ?? this.enddata,
      attendance: attendance ?? this.attendance,
      absence: absence ?? this.absence,
      status: status ?? this.status,
      note: note ?? this.note,
      gender: gender ?? this.gender,
    );
  }
}
