class SubModel {
  final String id;
  final String duration;
  final String enddate;
  final String freeze;
  final String invitation;
  final String startdate;
  final String type;
  final String status;
  final String price;
  final String maxAttendance;

  SubModel({
    required this.id,
    required this.duration,
    required this.enddate,
    required this.freeze,
    required this.invitation,
    required this.startdate,
    required this.type,
    required this.status,
    required this.price,
    required this.maxAttendance,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'duration': duration,
      'enddate': enddate,
      'freeze': freeze,
      'invitation': invitation,
      'startdate': startdate,
      'type': type,
      'status': status,
      'price': price,
      'maxAttendance': maxAttendance,
    };
  }

  factory SubModel.fromJson(Map<String, dynamic> map, String docId) {
    return SubModel(
      id: docId,
      duration: map['duration'] ?? '',
      enddate: map['enddate'] ?? '',
      freeze: map['freeze'] ?? '',
      invitation: map['invitation'] ?? '',
      startdate: map['startdate'] ?? '',
      type: map['type'] ?? '',
      status: map['status'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      maxAttendance: map['maxAttendance'] ?? 0,
    );
  }

  SubModel copyWith({
    String? id,
    String? duration,
    String? enddate,
    String? freeze,
    String? invitation,
    String? startdate,
    String? type,
    String? status,
    String? price,
    String? maxAttendance,
  }) {
    return SubModel(
      id: id ?? this.id,
      duration: duration ?? this.duration,
      enddate: enddate ?? this.enddate,
      freeze: freeze ?? this.freeze,
      invitation: invitation ?? this.invitation,
      startdate: startdate ?? this.startdate,
      type: type ?? this.type,
      status: status ?? this.status,
      price: price ?? this.price,
      maxAttendance: maxAttendance ?? this.maxAttendance,
    );
  }
}
