import 'package:power_gym/features/members/data/models/member_model/members_count_mode.dart';

class MembersCountForDashboardState {}

class MembersCountForDashboardInitial extends MembersCountForDashboardState {}

class MembersCountForDashboardLoading extends MembersCountForDashboardState {}

class MembersCountForDashboardLoaded extends MembersCountForDashboardState {
  final MembersCountMode count;
  MembersCountForDashboardLoaded(this.count);
}

class MembersCountForDashboardError extends MembersCountForDashboardState {
  final String message;
  MembersCountForDashboardError(this.message);
}
