import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:power_gym/features/report/data/models/model/attendance_report_mode.dart';
import 'package:power_gym/features/report/data/models/repo/daily_attendance_repo.dart';

class DailyAttendanceRepoImpl implements DailyAttendanceRepo {
  final FirebaseFirestore firestore;

  DailyAttendanceRepoImpl(this.firestore);

  @override
  Future<List<AttendanceReportModel>> getDailyAttendance(String dateId) async {
    final snap = await firestore
        .collection('attendance')
        .doc(dateId)
        .collection('members')
        .get();

    final List<AttendanceReportModel> result = [];

    for (final doc in snap.docs) {
      final data = doc.data();

      result.add(
        AttendanceReportModel(
          attendanceCount: result.length,
          memberName: data['name'] ?? '',
          memberId: data['memberId'] ?? '',
          startDate: _parseDate(data['startDate']),
          endDate: _parseDate(data['endDate']),
          status: data['status'] ?? '',
          attendanceTime: _parseDate(data['time']),
          note: data['note'] ?? '',
        ),
      );
    }

    return result;
  }

  DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime(1970);

    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is String) {
      return DateTime.parse(value);
    }

    throw Exception('Invalid date type: ${value.runtimeType}');
  }
}
