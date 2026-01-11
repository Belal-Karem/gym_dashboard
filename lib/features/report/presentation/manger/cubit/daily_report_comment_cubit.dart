import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:power_gym/features/report/data/models/model/daily_report_comment.dart';
import 'package:power_gym/features/report/data/models/repo/daily_report_comment_repo.dart';

part 'daily_report_comment_state.dart';

class DailyReportCommentCubit extends Cubit<DailyReportCommentState> {
  final DailyReportCommentRepo repo;

  DailyReportCommentCubit(this.repo) : super(DailyReportCommentStateInitial());

  Future<void> loadComment([String? dateId]) async {
    emit(DailyReportCommentStateLoading());

    try {
      final id = dateId ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
      final comment = await repo.getByDate(id);
      emit(DailyReportCommentStateLoaded(comment));
    } catch (e) {
      emit(DailyReportCommentStateError(e.toString()));
    }
  }

  Future<void> addOrUpdateComment(DailyReportComment comment) async {
    try {
      await repo.upsert(comment.date, comment.comment);
      await loadComment(comment.date);
    } catch (e) {
      emit(DailyReportCommentStateError(e.toString()));
    }
  }

  Future<void> deleteComment(String dateId) async {
    try {
      await repo.delete(dateId);
      await loadComment(dateId);
    } catch (e) {
      emit(DailyReportCommentStateError(e.toString()));
    }
  }
}
