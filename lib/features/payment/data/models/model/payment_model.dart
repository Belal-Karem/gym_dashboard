class PaymentModel {
  final String id;
  final String memberId;
  final String type;
  final double paid;
  final String paymentMethod;
  final String plan;
  final DateTime date;

  PaymentModel({
    required this.id,
    required this.memberId,
    required this.type,
    required this.paid,
    required this.paymentMethod,
    required this.plan,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'memberId': memberId,
      'type': type,
      'paid': paid,
      'paymentMethod': paymentMethod,
      'plan': plan,
      'date': date.toIso8601String(),
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> map, String docId) {
    return PaymentModel(
      id: docId,
      memberId: map['memberId'] ?? '',
      type: map['type'] ?? '',
      paid: (map['paid'] ?? '0').toDouble(),
      paymentMethod: map['paymentMethod'] ?? '',
      plan: map['plan'] ?? '',
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  PaymentModel copyWith({
    String? id,
    String? memberId,
    String? type,
    double? paid,
    String? paymentMethod,
    String? plan,
    DateTime? date,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      type: type ?? this.type,
      paid: paid ?? this.paid,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      plan: plan ?? this.plan,
      date: date ?? this.date,
    );
  }
}
