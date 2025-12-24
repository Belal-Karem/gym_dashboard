part of 'daily_summary_cubit.dart';

abstract class DailySummaryState {}

class DailySummaryInitial extends DailySummaryState {}

class DailySummaryLoading extends DailySummaryState {}

class DailySummaryLoaded extends DailySummaryState {
  final DailySummaryModel summary;
  DailySummaryLoaded(this.summary);
}

class DailySummaryError extends DailySummaryState {
  final String message;
  DailySummaryError(this.message);
}
