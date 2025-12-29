import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:power_gym/features/payment/data/models/model/payment_model.dart';
import 'package:power_gym/features/payment/data/models/repo/payment_repo.dart';
import 'package:power_gym/features/plan_and_packages/data/models/plan_model/plan_model.dart';
import 'package:power_gym/features/plan_and_packages/data/models/repo/plan_repo.dart';

part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  final PlanRepo repo;
  final PaymentRepo paymentRepo;

  PlanCubit(this.repo, this.paymentRepo) : super(PlanInitial());
  List<PlanModel> _allPlan = [];
  String _searchQuery = '';
  String _statusFilter = 'all';

  StreamSubscription? _panSubscription;

  Future<void> loadPlan() async {
    emit(PlanLoading());

    final result = await repo.getAllPlan();

    result.fold((failure) => emit(PlanError(failure.message)), (stream) {
      _panSubscription = stream.listen(
        (plans) {
          _allPlan = plans;
          _applyFilters();
          emit(PlanLoaded(plans));
        },
        onError: (error) {
          emit(PlanError(error.toString()));
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
    List<PlanModel> filtered = List.from(_allPlan);

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((paln) {
        return paln.member.name.toLowerCase().contains(
          _searchQuery.toLowerCase(),
        );
      }).toList();
    }

    if (_statusFilter != 'all') {
      filtered = filtered.where((paln) {
        return paln.status == _statusFilter;
      }).toList();
    }

    emit(PlanLoaded(filtered));
  }

  void resetFilters() {
    _searchQuery = '';
    _statusFilter = 'all';
    _applyFilters();
  }

  Future<void> addPlan(PlanModel plan) async {
    emit(AddPlanLoading());

    final hasActive = await repo.hasActivePrivatePlan(plan.member.id);
    if (hasActive) {
      emit(AddPlanError('العضو مشترك بالفعل في Private Plan نشط'));
      return;
    }

    final result = await repo.addPlan(plan);

    result.fold(
      (failure) {
        emit(AddPlanError(failure.message));
      },
      (_) async {
        await paymentRepo.addPayment(
          PaymentModel(
            id: '',
            memberId: plan.member.id,
            type: plan.member.name,
            paid: plan.price,
            plan: 'pt',
            paymentMethod: plan.method, // أو plan.method لو موجود
            date: DateTime.now(),
            status: 'income',
          ),
        );

        emit(AddPlanSuccess());
      },
    );
  }

  Future<void> updatePlan(String id, Map<String, dynamic> data) async {
    emit(UpdatePlanLoading());

    final result = await repo.updatePlan(id, data);

    result.fold(
      (failure) => emit(UpdatePlanError(failure.message)),
      (_) => emit(UpdatePlanSuccess()),
    );
  }

  Future<void> deletePlan(String id) async {
    emit(DeletePlanLoading());

    final result = await repo.deletePlan(id);

    result.fold(
      (failure) => emit(DeletePlanError(failure.message)),
      (_) => emit(DeletePlanSuccess()),
    );
  }

  @override
  Future<void> close() {
    _panSubscription?.cancel();
    return super.close();
  }
}
