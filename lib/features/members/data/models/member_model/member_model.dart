import 'package:power_gym/constants.dart';

class MemberModel {
  final String id, name, phone;
  final String startdata, enddata, absence, attendance;

  MemberModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.startdata,
    required this.enddata,
    required this.absence,
    required this.attendance,
  });
  factory MemberModel.fromjson(jsondata) {
    return MemberModel(
      id: jsondata[kid],
      name: jsondata[kname],
      phone: jsondata[kPhone],
      startdata: jsondata[kStartdate],
      enddata: jsondata[kenddate],
      absence: jsondata[kabsence],
      attendance: jsondata[kattendance],
    );
  }
}
