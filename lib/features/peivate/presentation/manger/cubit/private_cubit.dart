import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/payment/data/models/model/payment_model.dart';
import 'package:power_gym/features/payment/data/models/repo/payment_repo.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/peivate/data/models/private_model/private_model.dart';
import 'package:power_gym/features/peivate/data/models/repo/Private_repo.dart';

part 'private_state.dart';

class PrivateCubit extends Cubit<PrivateState> {
  final PrivateRepo repo;
  final PaymentRepo paymentRepo;

  PrivateCubit(this.repo, this.paymentRepo) : super(PrivateInitial());
  List<PrivateModel> _allPrivate = [];
  String _searchQuery = '';
  String _statusFilter = 'all';

  StreamSubscription? _panSubscription;

  Future<void> loadPrivate() async {
    emit(PrivateLoading());

    final result = await repo.getAllPrivate();

    result.fold((failure) => emit(PrivateError(failure.message)), (stream) {
      _panSubscription = stream.listen(
        (Privates) {
          _allPrivate = Privates;
          _applyFilters();
          emit(PrivateLoaded(Privates));
        },
        onError: (error) {
          emit(PrivateError(error.toString()));
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
    List<PrivateModel> filtered = List.from(_allPrivate);

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((paln) {
        return paln.member.name.toLowerCase().contains(
          _searchQuery.toLowerCase(),
        );
      }).toList();
    }

    if (_statusFilter != 'all') {
      filtered = filtered.where((private) {
        return private.status == _statusFilter;
      }).toList();
    }

    emit(PrivateLoaded(filtered));
  }

  void resetFilters() {
    _searchQuery = '';
    _statusFilter = 'all';
    _applyFilters();
  }

  Future<void> addPrivate(
    PrivateModel private,
    PaymentCubit paymentCubit,
  ) async {
    emit(AddPrivateLoading());

    final hasActive = await repo.hasActivePrivatePlan(private.member.id);
    if (hasActive) {
      emit(AddPrivateError('العضو مشترك بالفعل في Private  نشط'));
      return;
    }

    final result = await repo.addPrivate(private);

    result.fold(
      (failure) {
        emit(AddPrivateError(failure.message));
      },
      (_) async {
        await paymentCubit.addPayment(
          PaymentModel(
            id: '',
            memberId: private.member.id,
            type: private.member.name,
            plan: 'pt',
            paymentMethod: private.method,
            date: DateTime.now(),
            status: 'income',
            paid: private.paid,
          ),
        );
        emit(AddPrivateSuccess());
      },
    );
  }

  Future<void> takePrivateAttendance(PrivateModel plan) async {
    if (plan.status != PrivateStatus.active) return;

    emit(UpdatePrivateLoading());

    final now = DateTime.now();

    final newUsedSessions = plan.usedSessions + 1;

    final isExpiredBySessions = newUsedSessions >= plan.totalSessions;

    final isExpiredByDate = now.isAfter(plan.endDate);

    final newStatus = (isExpiredBySessions || isExpiredByDate)
        ? PrivateStatus.expired
        : PrivateStatus.active;

    final result = await repo.updatePrivate(plan.id, {
      'usedSessions': newUsedSessions,
      'status': newStatus.name,
    });

    result.fold(
      (failure) => emit(UpdatePrivateError(failure.message)),
      (_) => emit(UpdatePrivateSuccess()),
    );
  }

  Future<void> deletePrivate(String id) async {
    emit(DeletePrivateLoading());

    final result = await repo.deletePrivate(id);

    result.fold(
      (failure) => emit(DeletePrivateError(failure.message)),
      (_) => emit(DeletePrivateSuccess()),
    );
  }

  @override
  Future<void> close() {
    _panSubscription?.cancel();
    return super.close();
  }
}
