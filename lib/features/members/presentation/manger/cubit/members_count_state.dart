part of 'members_count_cubit.dart';

class MembersStatsState {}

class MembersStatsInitial extends MembersStatsState {}

class MembersStatsLoading extends MembersStatsState {}

class MembersStatsLoaded extends MembersStatsState {
  final MembersCountMode count;
  MembersStatsLoaded(this.count);
}

class MembersStatsError extends MembersStatsState {
  final String message;
  MembersStatsError(this.message);
}
