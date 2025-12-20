part of 'recent_member_cubit.dart';

abstract class RecentMemberState {}

class RecentMemberInitial extends RecentMemberState {}

class RecentMemberLoading extends RecentMemberState {}

class RecentMemberLoaded extends RecentMemberState {
  final List<RecentMemberModel> members;
  RecentMemberLoaded(this.members);
}

class RecentMemberError extends RecentMemberState {
  final String message;
  RecentMemberError(this.message);
}
