import 'package:power_gym/constants.dart';

class PaymentModel {
  final String id;
  final String type;
  final String paid;
  final String paymentData;
  final String paymentMethod;
  final String plan;

  PaymentModel({
    required this.id,
    required this.type,
    required this.paid,
    required this.paymentData,
    required this.paymentMethod,
    required this.plan,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      ktype: type,
      kpaid: paid,
      kpaymentDate: paymentData,
      kpaymentMethod: paymentMethod,
      kplan: plan,
    };
  }

  factory PaymentModel.fromJson(Map<String, dynamic> map, String docId) {
    return PaymentModel(
      id: docId,

      type: map[ktype] ?? '',
      paid: map[kpaid] ?? '',
      paymentData: map[kpaymentDate] ?? '',
      paymentMethod: map[kpaymentMethod] ?? '',
      plan: map[kplan] ?? '',
    );
  }

  PaymentModel copyWith({
    String? id,
    String? type,
    String? paymentDate,
    String? paymentMethod,
    String? paid,
    String? plan,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      paymentData: paymentDate ?? this.paymentData,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paid: paid ?? this.paid,
      plan: plan ?? this.plan,
      type: type ?? this.type,
    );
  }
}
