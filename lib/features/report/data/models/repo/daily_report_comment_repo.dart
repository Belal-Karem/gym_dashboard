import 'package:power_gym/features/report/data/models/model/daily_report_comment.dart';

abstract class DailyReportCommentRepo {
  Future<DailyReportComment?> getByDate(String date);
  Future<void> upsert(String date, String comment);
  Future<void> delete(String date);
}
