class AttendanceModel {
  final String id;
  final String memberId;
  final DateTime date;
  final DateTime time;

  AttendanceModel({
    required this.id,
    required this.memberId,
    required this.date,
    required this.time,
  });
}
