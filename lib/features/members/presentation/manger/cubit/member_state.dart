// part of 'member_cubit.dart';

// @immutable
// sealed class MemberState {}

// final class MemberInitial extends MemberState {}

import 'package:equatable/equatable.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

abstract class MembersState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// الحالة المبدئية
class MembersInitial extends MembersState {}

/// تحميل جميع الأعضاء (Stream)
class MembersLoading extends MembersState {}

class MembersLoaded extends MembersState {
  final List<MemberModel> members;

  MembersLoaded(this.members);

  @override
  List<Object?> get props => [members];
}

class MembersError extends MembersState {
  final String message;

  MembersError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddMemberLoading extends MembersState {}

class AddMemberSuccess extends MembersState {}

class AddMemberError extends MembersState {
  final String message;

  AddMemberError(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateMemberLoading extends MembersState {}

class UpdateMemberSuccess extends MembersState {}

class UpdateMemberError extends MembersState {
  final String message;

  UpdateMemberError(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteMemberLoading extends MembersState {}

class DeleteMemberSuccess extends MembersState {}

class DeleteMemberError extends MembersState {
  final String message;

  DeleteMemberError(this.message);

  @override
  List<Object?> get props => [message];
}
