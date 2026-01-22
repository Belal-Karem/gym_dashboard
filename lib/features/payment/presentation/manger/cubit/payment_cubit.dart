import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_state.dart';
import 'package:power_gym/features/payment/data/models/model/payment_model.dart';
import 'package:power_gym/features/payment/data/models/repo/payment_repo.dart';

// class PaymentCubit extends Cubit<PaymentState> {
//   final PaymentRepo repo;
//   StreamSubscription? _paymentSubscription;

//   PaymentCubit(this.repo) : super(PaymentInitial());

//   Future<void> loadPayment() async {
//     emit(PaymentLoading());

//     final result = await repo.getAllPayment();

//     result.fold((failure) => emit(PaymentError(failure.message)), (stream) {
//       _paymentSubscription?.cancel();

//       _paymentSubscription = stream.listen(
//         (allPayments) {
//           final now = DateTime.now();
//           final start = DateTime(now.year, now.month, now.day);
//           final end = DateTime(now.year, now.month, now.day, 23, 59, 59);

//           final todayIncome = allPayments.where((p) {
//             return p.date.isAfter(start) && p.date.isBefore(end);
//           }).toList();

//           final totalIncomeToday = todayIncome.fold<double>(
//             0.0,
//             (sum, p) => sum + double.parse(p.paid),
//           );

//           emit(
//             PaymentLoaded(payments: todayIncome, totalToday: totalIncomeToday),
//           );
//         },
//         onError: (error) {
//           emit(PaymentError(error.toString()));
//         },
//       );
//     });
//   }

//   Future<void> addPayment(PaymentModel payment) async {
//     emit(AddPaymentLoading());

//     final result = await repo.addPayment(payment);

//     result.fold(
//       (failure) => emit(AddPaymentError(failure.message)),
//       (_) => emit(AddPaymentSuccess()),
//     );
//   }

//   @override
//   Future<void> close() {
//     _paymentSubscription?.cancel();
//     return super.close();
//   }
// }

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo repo;
  StreamSubscription? _paymentSubscription;
  List<PaymentModel> _allPayment = [];

  String _searchQuery = '';
  String _statusFilter = 'all';

  PaymentCubit(this.repo) : super(PaymentInitial());

  Future<void> loadPayment() async {
    emit(PaymentLoading());

    final result = await repo.getAllPayment();

    result.fold((failure) => emit(PaymentError(failure.message)), (stream) {
      _paymentSubscription?.cancel();

      _paymentSubscription = stream.listen(
        (allPayments) {
          _allPayment = allPayments;
          _applyFilters();
        },
        onError: (error) {
          emit(PaymentError(error.toString()));
        },
      );
    });
  }

  void searchMembers(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterByStatus(String status) {
    _statusFilter = status;
    _applyFilters();
  }

  void _applyFilters() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59);

    List<PaymentModel> filtered = List.from(_allPayment);

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((payment) {
        return payment.type.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (_statusFilter != 'all') {
      filtered = filtered.where((payment) {
        return payment.paymentMethod == _statusFilter;
      }).toList();
    }

    // حساب اليوم بعد تطبيق الفلاتر
    final todayFilteredPayments = filtered.where((p) {
      return p.date.isAfter(start) && p.date.isBefore(end);
    }).toList();

    final totalIncomeToday = todayFilteredPayments
        .where((p) => p.status == 'income')
        .fold<double>(0.0, (sum, p) => sum + double.parse(p.paid));

    final totalOutcomeToday = todayFilteredPayments
        .where((p) => p.status == 'expense')
        .fold<double>(0.0, (sum, p) => sum + double.parse(p.paid));

    emit(
      PaymentLoaded(
        payments: todayFilteredPayments,
        totalIncomeToday: totalIncomeToday,
        totalOutcomeToday: totalOutcomeToday,
      ),
    );
  }

  void resetFilters() {
    _searchQuery = '';
    _statusFilter = 'all';
    _applyFilters();
  }

  Future<void> addPayment(PaymentModel payment) async {
    emit(AddPaymentLoading());

    final result = await repo.addPayment(payment);

    result.fold((failure) => emit(AddPaymentError(failure.message)), (_) {
      // أضف الدفع الجديد محليًا مؤقتًا لحساب total فورًا
      _allPayment = List.from(_allPayment)..add(payment);
      _applyFilters();
      emit(AddPaymentSuccess());
    });
  }

  @override
  Future<void> close() {
    _paymentSubscription?.cancel();
    return super.close();
  }
}
