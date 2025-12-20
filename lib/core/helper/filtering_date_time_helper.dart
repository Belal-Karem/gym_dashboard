import 'package:power_gym/features/payment/data/models/model/payment_model.dart';

class FilteringDateTimeHelper {
  DateTime startOfToday() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  DateTime endOfToday() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 23, 59, 59);
  }

  List<PaymentModel> todayPayments(List<PaymentModel> allPayments) {
    final start = startOfToday();
    final end = endOfToday();

    return allPayments.where((p) {
      return p.date.isAfter(start) && p.date.isBefore(end);
    }).toList();
  }

  double totalTodayPayments(List<PaymentModel> payments) {
    return payments.fold(0.0, (sum, p) => sum + int.parse(p.paid).toDouble());
  }
}
