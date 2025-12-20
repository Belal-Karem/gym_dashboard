import 'package:power_gym/features/home/data/models/model/recent_member_model.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';

abstract class AttendanceRepo {
  Future<void> markAttendance(MemberModel member);
  Stream<int> getTodayAttendanceCount();
  Stream<List<RecentMemberModel>> getTodayRecentMembers();
}
