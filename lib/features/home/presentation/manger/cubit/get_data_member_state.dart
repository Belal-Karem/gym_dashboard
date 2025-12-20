part of 'get_data_member_cubit.dart';

abstract class GetDataMemberState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDataMemberInitial extends GetDataMemberState {}

class GetDataMemberLoading extends GetDataMemberState {}

class GetDataMemberLoaded extends GetDataMemberState {
  final List<MemberModel> members;

  GetDataMemberLoaded(this.members);

  @override
  List<Object?> get props => [members];
}

class GetDataMemberError extends GetDataMemberState {
  final String message;

  GetDataMemberError(this.message);

  @override
  List<Object?> get props => [message];
}
