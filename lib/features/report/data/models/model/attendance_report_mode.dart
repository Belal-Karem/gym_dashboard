class AttendanceReportModel {
  final String memberName;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final DateTime attendanceTime;
  final String note;

  AttendanceReportModel({
    required this.memberName,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.attendanceTime,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'memberName': memberName,
      'startDate': startDate,
      'endDate': endDate,
      'status': status,
      'attendanceTime': attendanceTime,
      'note': note,
    };
  }
}
