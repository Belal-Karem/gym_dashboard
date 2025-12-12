part of 'plan_cubit.dart';

abstract class PlanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlanInitial extends PlanState {}

class PlanLoading extends PlanState {}

class PlanLoaded extends PlanState {
  final List<PlanModel> plan;

  PlanLoaded(this.plan);

  @override
  List<Object?> get props => [plan];
}

class PlanError extends PlanState {
  final String message;

  PlanError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddPlanLoading extends PlanState {}

class AddPlanSuccess extends PlanState {}

class AddPlanError extends PlanState {
  final String message;

  AddPlanError(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdatePlanLoading extends PlanState {}

class UpdatePlanSuccess extends PlanState {}

class UpdatePlanError extends PlanState {
  final String message;

  UpdatePlanError(this.message);

  @override
  List<Object?> get props => [message];
}

class DeletePlanLoading extends PlanState {}

class DeletePlanSuccess extends PlanState {}

class DeletePlanError extends PlanState {
  final String message;

  DeletePlanError(this.message);

  @override
  List<Object?> get props => [message];
}
