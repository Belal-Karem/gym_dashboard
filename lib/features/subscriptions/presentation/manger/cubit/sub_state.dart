import 'package:equatable/equatable.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

abstract class SubState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubInitial extends SubState {}

class SubLoading extends SubState {}

class SubLoaded extends SubState {
  final List<SubModel> sub;

  SubLoaded(this.sub);

  @override
  List<Object?> get props => [sub];
}

class SubError extends SubState {
  final String message;

  SubError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddSubLoading extends SubState {}

class AddSubSuccess extends SubState {}

class AddSubError extends SubState {
  final String message;

  AddSubError(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateSubLoading extends SubState {}

class UpdateSubSuccess extends SubState {}

class UpdateSubError extends SubState {
  final String message;

  UpdateSubError(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteSubLoading extends SubState {}

class DeleteSubSuccess extends SubState {}

class DeleteSubError extends SubState {
  final String message;

  DeleteSubError(this.message);

  @override
  List<Object?> get props => [message];
}
