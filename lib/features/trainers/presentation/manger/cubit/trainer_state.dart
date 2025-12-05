part of 'trainer_cubit.dart';

abstract class TrainerState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// الحالة المبدئية
class TrainerInitial extends TrainerState {}

/// تحميل جميع الأعضاء (Stream)
class TrainerLoading extends TrainerState {}

class TrainerLoaded extends TrainerState {
  final List<TrainerModel> trainer;

  TrainerLoaded(this.trainer);

  @override
  List<Object?> get props => [trainer];
}

class TrainerError extends TrainerState {
  final String message;

  TrainerError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddTrainerLoading extends TrainerState {}

class AddTrainerSuccess extends TrainerState {}

class AddTrainerError extends TrainerState {
  final String message;

  AddTrainerError(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateTrainerLoading extends TrainerState {}

class UpdateTrainerSuccess extends TrainerState {}

class UpdateTrainerError extends TrainerState {
  final String message;

  UpdateTrainerError(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteTrainerLoading extends TrainerState {}

class DeleteTrainerSuccess extends TrainerState {}

class DeleteTrainerError extends TrainerState {
  final String message;

  DeleteTrainerError(this.message);

  @override
  List<Object?> get props => [message];
}
