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

  StreamSubscription? _panSubscription;

  Future<void> loadPlan() async {
    emit(PlanLoading());

    final result = await repo.getAllPlan();

    result.fold((failure) => emit(PlanError(failure.message)), (stream) {
      _panSubscription = stream.listen(
        (plans) {
          // plans: List<PlanModel>
          emit(PlanLoaded(plans));
        },
        onError: (error) {
          emit(PlanError(error.toString()));
        },
      );
    });
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
