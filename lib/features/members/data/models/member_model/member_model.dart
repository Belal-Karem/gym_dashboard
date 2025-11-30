class MemberModel {
  final String id;
  final String memberid;
  final String name;
  final String phone;
  final String startdata;
  final String enddata;
  final String attendance;
  final String absence;
  final String status;

  MemberModel({
    required this.memberid,
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
    };
  }

  factory MemberModel.fromJson(Map<String, dynamic> map, String docId) {
    return MemberModel(
      id: docId,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      startdata: map['startdata'] ?? '',
      enddata: map['enddata'] ?? '',
      attendance: map['attendance'] ?? '',
      absence: map['absence'] ?? '',
      status: map['status'] ?? '',
      memberid: map['id'],
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
      memberid: memberid ?? this.memberid,
    );
  }
}
