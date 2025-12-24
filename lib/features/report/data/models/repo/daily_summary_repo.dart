import 'package:power_gym/features/report/data/models/model/daily_summary_model.dart';

abstract class DailySummaryRepo {
  Future<DailySummaryModel> getDailySummary(String dateId);
}
