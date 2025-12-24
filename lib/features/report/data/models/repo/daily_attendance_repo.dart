import 'package:power_gym/features/report/data/models/model/attendance_report_mode.dart';

abstract class DailyAttendanceRepo {
  Future<List<AttendanceReportModel>> getDailyAttendance(String dateId);
}
