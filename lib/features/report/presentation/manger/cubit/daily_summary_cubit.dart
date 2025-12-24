import 'package:bloc/bloc.dart';
import 'package:power_gym/features/report/data/models/model/daily_summary_model.dart';
import 'package:power_gym/features/report/data/models/repo/daily_summary_repo.dart';

part 'daily_summary_state.dart';

class DailySummaryCubit extends Cubit<DailySummaryState> {
  final DailySummaryRepo repo;

  DailySummaryCubit(this.repo) : super(DailySummaryInitial());

  Future<void> load(String dateId) async {
    emit(DailySummaryLoading());

    try {
      final summary = await repo.getDailySummary(dateId);
      emit(DailySummaryLoaded(summary));
    } catch (e) {
      emit(DailySummaryError(e.toString()));
    }
  }
}
