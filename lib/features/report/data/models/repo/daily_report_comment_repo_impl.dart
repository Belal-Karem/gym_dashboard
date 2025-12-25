import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:power_gym/features/report/data/models/model/daily_report_comment.dart';
import 'package:power_gym/features/report/data/models/repo/daily_report_comment_repo.dart';

class DailyReportCommentRepoImpl implements DailyReportCommentRepo {
  final FirebaseFirestore firestore;

  DailyReportCommentRepoImpl(this.firestore);

  @override
  Future<DailyReportComment?> getByDate(String date) async {
    final doc = await firestore
        .collection('daily_report_notes')
        .doc(date)
        .get();

    if (!doc.exists) return null;

    return DailyReportComment.fromMap(doc.data()!);
  }

  @override
  Future<void> upsert(String date, String comment) async {
    await firestore.collection('daily_report_notes').doc(date).set({
      'date': date,
      'comment': comment,
      'updatedAt': Timestamp.now(),
    }, SetOptions(merge: true));
  }

  @override
  Future<void> delete(String date) async {
    await firestore.collection('daily_report_notes').doc(date).delete();
  }
}
