import 'package:cloud_firestore/cloud_firestore.dart';

class DailyReportComment {
  final String date;
  final String comment;
  final DateTime updatedAt;

  DailyReportComment({
    required this.date,
    required this.comment,
    required this.updatedAt,
  });

  factory DailyReportComment.fromMap(Map<String, dynamic> map) {
    return DailyReportComment(
      date: map['date'],
      comment: map['comment'],
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'comment': comment,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
