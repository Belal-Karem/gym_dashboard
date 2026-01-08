import 'package:power_gym/features/home/data/models/model/recent_member_model.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

abstract class AttendanceRepo {
  Future<void> markAttendance(MemberSubscriptionModel sub, SubModel plan);
  Stream<int> getTodayAttendanceCount();
  Stream<List<RecentMemberModel>> getTodayRecentMembers();
}
