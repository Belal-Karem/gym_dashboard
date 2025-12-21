import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_state.dart';
import 'package:power_gym/features/payment/data/models/model/payment_model.dart';
import 'package:power_gym/features/payment/data/models/repo/payment_repo.dart';

class PaymentCubit extends Cubit<PaymentState> {
 final PaymentRepo repo;
  StreamSubscription? _paymentSubscription;

  PaymentCubit(this.repo) : super(PaymentInitial());

  Future<void> loadPayment() async {
    emit(PaymentLoading());

    final result = await repo.getAllPayment();

    result.fold(
      (failure) => emit(PaymentError(failure.message)),
      (stream) {
        _paymentSubscription?.cancel();

        _paymentSubscription = stream.listen(
          (allPayments) {
            final now = DateTime.now();
            final start =
                DateTime(now.year, now.month, now.day);
            final end =
                DateTime(now.year, now.month, now.day, 23, 59, 59);

            // 👇 فلترة مصاريف اليوم
            final todayPayments = allPayments.where((p) {
              return p.date.isAfter(start) &&
                  p.date.isBefore(end);
            }).toList();

            // 👇 حساب الإجمالي
            final totalToday = todayPayments.fold<double>(
              0.0,
              (sum, p) => sum + int.parse(p.paid),
            );

            emit(
              PaymentLoaded(
                payments: todayPayments,
                totalToday: totalToday,
              ),
            );
          },
          onError: (error) {
            emit(PaymentError(error.toString()));
          },
        );
      },
    );
  }
  Future<void> addPayment(PaymentModel payment) async {
    emit(AddPaymentLoading());

    final result = await repo.addPayment(payment);

    result.fold(
      (failure) => emit(AddPaymentError(failure.message)),
      (_) => emit(AddPaymentSuccess()),
    );
  }

  @override
  Future<void> close() {
    _paymentSubscription?.cancel();
    return super.close();
  }
}
