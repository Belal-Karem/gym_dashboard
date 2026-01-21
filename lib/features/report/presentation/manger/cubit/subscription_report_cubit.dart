import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/report/data/models/repo/subscription_report_repo.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/subscription_report_state.dart';

class SubscriptionReportCubit extends Cubit<SubscriptionReportState> {
  final SubscriptionReportRepo repo;

  SubscriptionReportCubit(this.repo) : super(SubscriptionReportInitial());

  /// تقرير يوم كامل (أفضل اختيار)
  // Future<void> loadDayReport(String dateId) async {
  //   emit(SubscriptionReportLoading());

  //   try {
  //     final result = await repo.getDayReport(dateId);

  //     emit(
  //       SubscriptionReportLoaded(
  //         newSubscriptions: result.newSubscriptions,
  //         renewals: result.renewals,
  //       ),
  //     );
  //   } catch (e) {
  //     emit(SubscriptionReportError(e.toString()));
  //   }
  // }

  Future<void> loadSeparately(String dateId) async {
    emit(SubscriptionReportLoading());

    try {
      final newSubs = await repo.getNewSubscriptions(dateId);
      final renewals = await repo.getRenewedSubscriptions(dateId);
      print('newSubs: $newSubs');
      emit(
        SubscriptionReportLoaded(newSubscriptions: newSubs, renewals: renewals),
      );
    } catch (e) {
      emit(SubscriptionReportError(e.toString()));
    }
  }
}
