import 'package:power_gym/constants.dart';

class SubModel {
  final String id;
  final String duration;
  final int freeze;
  final int invitation;
  final String status;
  final String price;
  final String maxAttendance;
  final String type;

  SubModel({
    required this.id,
    required this.duration,
    required this.freeze,
    required this.invitation,
    required this.type,
    required this.status,
    required this.price,
    required this.maxAttendance,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'duration': duration,
      'freeze': freeze,
      'invitation': invitation,
      'status': status,
      'price': price,
      'maxAttendance': maxAttendance,
      'type': type,
    };
  }

  factory SubModel.fromJson(Map<String, dynamic> map, String docId) {
    return SubModel(
      id: docId,
      duration: map[kduration] ?? '',
      freeze: map[kfreeze] ?? '',
      invitation: map[kinvitation] ?? '',
      status: map[kstatus] ?? '',
      price: map[kprice] ?? '',
      maxAttendance: map[kmaxAttendance] ?? '',
      type: map[ktype] ?? '',
    );
  }

  SubModel copyWith({
    String? id,
    String? duration,
    int? freeze,
    int? invitation,
    String? type,
    String? status,
    String? price,
    String? maxAttendance,
  }) {
    return SubModel(
      id: id ?? this.id,
      duration: duration ?? this.duration,
      freeze: freeze ?? this.freeze,
      invitation: invitation ?? this.invitation,
      status: status ?? this.status,
      price: price ?? this.price,
      maxAttendance: maxAttendance ?? this.maxAttendance,
      type: type ?? this.type,
    );
  }
}
