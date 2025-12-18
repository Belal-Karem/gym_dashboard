import 'package:power_gym/features/payment/data/models/model/payment_model.dart';
import 'package:power_gym/features/payment/data/models/repo/payment_repo_impl.dart';

class PaymentActions {
  static final PaymentRepoImpl _repo = PaymentRepoImpl();

  static Future<void> recordPayment({
    required String memberId,
    required double paid, // double بدل String
    required String plan,
    required DateTime date, // DateTime بدل String
    required String name,
    required String paymentMethod,
  }) async {
    final payment = PaymentModel(
      id: '',
      memberId: memberId,
      paid: paid,
      plan: plan,
      date: date,
      paymentMethod: paymentMethod,
      type: name,
    );

    await _repo.addPayment(payment);
  }
}
