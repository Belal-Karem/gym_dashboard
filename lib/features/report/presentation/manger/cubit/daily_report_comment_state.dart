part of 'daily_report_comment_cubit.dart';

abstract class DailyReportCommentState {}

class DailyReportCommentStateInitial extends DailyReportCommentState {}

class DailyReportCommentStateLoading extends DailyReportCommentState {}

class DailyReportCommentStateLoaded extends DailyReportCommentState {
  final DailyReportComment? comment;
  DailyReportCommentStateLoaded(this.comment);
}

class DailyReportCommentStateError extends DailyReportCommentState {
  final String message;
  DailyReportCommentStateError(this.message);
}
