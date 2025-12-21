import 'package:equatable/equatable.dart';
import 'package:power_gym/features/payment/data/models/model/payment_model.dart';

abstract class PaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<PaymentModel> payments;
  final double totalToday;

  PaymentLoaded({required this.payments, required this.totalToday});
}

class PaymentError extends PaymentState {
  final String message;

  PaymentError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddPaymentLoading extends PaymentState {}

class AddPaymentSuccess extends PaymentState {}

class AddPaymentError extends PaymentState {
  final String message;

  AddPaymentError(this.message);

  @override
  List<Object?> get props => [message];
}
