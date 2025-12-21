import 'package:power_gym/features/payment/data/models/model/payment_model.dart';
import 'package:power_gym/features/payment/data/models/repo/payment_repo_impl.dart';

class PaymentActions {
  static final PaymentRepoImpl _repo = PaymentRepoImpl();

  static Future<void> recordPayment({
    required String memberId,
    required String paid,
    required String plan,
    required DateTime date,
    required String name,
    required String paymentMethod,
    required String status,
  }) async {
    final payment = PaymentModel(
      id: '',
      memberId: memberId,
      paid: paid,
      plan: plan,
      date: date,
      paymentMethod: paymentMethod,
      type: name,
      status: status,
    );

    await _repo.addPayment(payment);
  }
}
