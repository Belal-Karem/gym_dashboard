import 'package:power_gym/features/members/data/models/member_model/members_count_mode.dart';

class MembersCountStatsState {}

class MembersCountStatsInitial extends MembersCountStatsState {}

class MembersCountStatsLoading extends MembersCountStatsState {}

class MembersCountStatsLoaded extends MembersCountStatsState {
  final MembersCountMode count;
  MembersCountStatsLoaded(this.count);
}

class MembersCountStatsError extends MembersCountStatsState {
  final String message;
  MembersCountStatsError(this.message);
}
