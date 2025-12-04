class SubModel {
  final String id;
  final String duration;
  final String freeze;
  final String invitation;
  final String status;
  final String price;
  final String maxAttendance;

  SubModel({
    required this.id,
    required this.duration,
    required this.freeze,
    required this.invitation,

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
    };
  }

  factory SubModel.fromJson(Map<String, dynamic> map, String docId) {
    return SubModel(
      id: docId,
      duration: map['duration'] ?? '',
      freeze: map['freeze'] ?? '',
      invitation: map['invitation'] ?? '',
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
      freeze: freeze ?? this.freeze,
      invitation: invitation ?? this.invitation,
      status: status ?? this.status,
      price: price ?? this.price,
      maxAttendance: maxAttendance ?? this.maxAttendance,
    );
  }
}
