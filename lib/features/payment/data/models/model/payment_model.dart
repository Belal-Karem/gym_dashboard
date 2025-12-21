import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:power_gym/constants.dart';

class PaymentModel {
  final String id;
  final String type;
  final String paid;
  final String paymentMethod;
  final String plan;
  final DateTime date;
  final String memberId;
  final String status;

  PaymentModel({
    required this.memberId,
    required this.date,
    required this.id,
    required this.type,
    required this.paid,
    required this.paymentMethod,
    required this.plan,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      ktype: type,
      kpaid: paid,
      kpaymentMethod: paymentMethod,
      kplan: plan,
      kdate: Timestamp.fromDate(date),
      kmemberid: memberId,
      kstatus: status,
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> map, String docId) {
    return PaymentModel(
      id: docId,
      memberId: map[kmemberid] ?? '',
      date: map[kdate] != null
          ? (map[kdate] as Timestamp).toDate()
          : DateTime.now(),
      type: map[ktype] ?? '',
      paid: map[kpaid] ?? '',
      paymentMethod: map[kpaymentMethod] ?? '',
      plan: map[kplan] ?? '',
      status: map[kstatus] ?? '',
    );
  }

  PaymentModel copyWith({
    String? id,
    String? type,
    String? paymentDate,
    String? paymentMethod,
    String? paid,
    String? plan,
    DateTime? date,
    String? memberId,
    String? status,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      date: date ?? this.date,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paid: paid ?? this.paid,
      plan: plan ?? this.plan,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }
}
