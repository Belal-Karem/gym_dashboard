import 'package:bloc/bloc.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/all_comments_state.dart';
import 'package:power_gym/features/report/data/models/repo/daily_report_comment_repo.dart';

class AllCommentsCubit extends Cubit<AllCommentsState> {
  final DailyReportCommentRepo repo;

  AllCommentsCubit(this.repo) : super(AllCommentsInitial());

  Future<void> load() async {
    emit(AllCommentsLoading());
    try {
      final comments = await repo.getAllComments();
      emit(AllCommentsLoaded(comments));
    } catch (e) {
      emit(AllCommentsError(e.toString()));
    }
  }

  Future<void> delete(String dateId) async {
    await repo.delete(dateId);
    load(); // reload بعد الحذف
  }
}
