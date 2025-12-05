import 'package:power_gym/constants.dart';

class TrainerModel {
  final String id;
  final String name;
  final String phone;
  final String status;
  final String ptNumber;

  TrainerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.ptNumber,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'status': status,
      'ptNumber': ptNumber,
    };
  }

  factory TrainerModel.fromJson(Map<String, dynamic> map, String docId) {
    return TrainerModel(
      id: docId,
      name: map[kname] ?? '',
      phone: map[kPhone] ?? '',
      status: map[kstatus] ?? '',
      ptNumber: map[kptNumber] ?? '',
    );
  }

  TrainerModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? status,
    String? ptNumber,
  }) {
    return TrainerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      ptNumber: ptNumber ?? this.ptNumber,
    );
  }
}
