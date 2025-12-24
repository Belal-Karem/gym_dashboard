import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/core/errors/firebase_error_mapper.dart';
import 'package:power_gym/features/payment/data/models/model/payment_model.dart';
import 'package:power_gym/features/payment/data/models/repo/payment_repo.dart';

class PaymentRepoImpl implements PaymentRepo {
  final CollectionReference paymentsRef = FirebaseFirestore.instance.collection(
    kpaymentCollections,
  );

  @override
  Future<Either<Failure, Stream<List<PaymentModel>>>> getAllPayment() async {
    try {
      final stream = paymentsRef.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return PaymentModel.fromJson(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );
        }).toList();
      });

      return Right(stream);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> addPayment(PaymentModel payment) async {
    try {
      final docRef = paymentsRef.doc();

      final date = payment.date;
      final dateId =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

      await docRef.set(
        payment.copyWith(id: docRef.id, dateId: dateId).toJson(),
      );
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Stream<List<PaymentModel>>>> getTodayPayments() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

      final stream = paymentsRef
          .where('date', isGreaterThanOrEqualTo: startOfDay)
          .where('date', isLessThanOrEqualTo: endOfDay)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs.map((doc) {
              return PaymentModel.fromJson(
                doc.data() as Map<String, dynamic>,
                doc.id,
              );
            }).toList();
          });

      return Right(stream);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePayment(String id) async {
    try {
      await paymentsRef.doc(id).delete();
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }
}
