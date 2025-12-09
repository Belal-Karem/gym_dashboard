import 'package:dartz/dartz.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/features/payment/data/models/model/payment_model.dart';

abstract class PaymentRepo {
  Future<Either<Failure, Stream<List<PaymentModel>>>> getAllPayment();

  Future<Either<Failure, Unit>> addPayment(PaymentModel member);

  Future<Either<Failure, Unit>> updatePayment(
    String id,
    Map<String, dynamic> data,
  );

  Future<Either<Failure, Unit>> deletePayment(String id);
}
