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

    result.fold((failure) => emit(PaymentError(failure.message)), (stream) {
      _paymentSubscription = stream.listen(
        (payment) {
          emit(PaymentLoaded(payment));
        },
        onError: (error) {
          emit(PaymentError(error.toString()));
        },
      );
    });
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
