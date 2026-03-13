part of 'private_cubit.dart';

abstract class PrivateState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PrivateInitial extends PrivateState {}

class PrivateLoading extends PrivateState {}

class PrivateLoaded extends PrivateState {
  final List<PrivateModel> private;

  PrivateLoaded(this.private);

  @override
  List<Object?> get props => [private];
}

class PrivateError extends PrivateState {
  final String message;

  PrivateError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddPrivateLoading extends PrivateState {}

class AddPrivateSuccess extends PrivateState {}

class AddPrivateError extends PrivateState {
  final String message;

  AddPrivateError(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdatePrivateLoading extends PrivateState {}

class UpdatePrivateSuccess extends PrivateState {}

class UpdatePrivateError extends PrivateState {
  final String message;

  UpdatePrivateError(this.message);

  @override
  List<Object?> get props => [message];
}

class DeletePrivateLoading extends PrivateState {}

class DeletePrivateSuccess extends PrivateState {}

class DeletePrivateError extends PrivateState {
  final String message;

  DeletePrivateError(this.message);

  @override
  List<Object?> get props => [message];
}
