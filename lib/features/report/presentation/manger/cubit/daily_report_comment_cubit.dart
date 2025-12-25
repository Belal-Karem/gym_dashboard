import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:power_gym/features/report/data/models/model/daily_report_comment.dart';
import 'package:power_gym/features/report/data/models/repo/daily_report_comment_repo.dart';

part 'daily_report_comment_state.dart';

class DailyReportCommentCubit extends Cubit<DailyReportCommentState> {
  final DailyReportCommentRepo repo;

  DailyReportCommentCubit(this.repo) : super(DailyReportCommentStateInitial()) {
    loadCurrentDate();
  }

  String get currentDateId => DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> load(String date) async {
    emit(DailyReportCommentStateLoading());
    try {
      final comment = await repo.getByDate(date);
      emit(DailyReportCommentStateLoaded(comment));
    } catch (e) {
      emit(DailyReportCommentStateError(e.toString()));
    }
  }

  Future<void> loadCurrentDate() async {
    await load(currentDateId);
  }

  Future<void> addOrUpdateComment(DailyReportComment comment) async {
    emit(DailyReportCommentStateLoading());
    await repo.upsert(comment.date, comment.comment);
    final updated = await repo.getByDate(comment.date);
    emit(DailyReportCommentStateLoaded(updated));
  }

  Future<void> deleteComment(String dateId) async {
    emit(DailyReportCommentStateLoading());
    await repo.delete(dateId);
    emit(DailyReportCommentStateLoaded(null));
  }
}
