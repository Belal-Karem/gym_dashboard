class MemberModel {
  final String id;
  final String memberId;
  final String name;
  final String phone;
  final String gender;
  final String note;
  final DateTime affiliationDate;

  MemberModel({
    required this.id,
    required this.memberId,
    required this.name,
    required this.phone,
    required this.gender,
    required this.note,
    required this.affiliationDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'name': name,
      'phone': phone,
      'gender': gender,
      'note': note,
      'affiliationDate': affiliationDate.toIso8601String(),
    };
  }

  factory MemberModel.fromJson(Map<String, dynamic> map, String docId) {
    return MemberModel(
      id: docId,
      memberId: map['memberId'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      note: map['note'] ?? '',
      affiliationDate: DateTime.parse(map['affiliationDate']),
    );
  }
  MemberModel copyWith({
    String? id,
    String? memberId,
    String? name,
    String? phone,
    int? attendance,
    String? gender,
    String? note,
    DateTime? affiliationDate,
  }) {
    return MemberModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      note: note ?? this.note,
      gender: gender ?? this.gender,
      memberId: memberId ?? this.memberId,
      affiliationDate: affiliationDate ?? this.affiliationDate,
    );
  }
}
