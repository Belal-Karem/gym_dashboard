import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/report/data/models/repo/subscription_report_repo.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/subscription_list_state.dart';

class SubscriptionListCubit extends Cubit<SubscriptionListState> {
  final SubscriptionReportRepo repo;

  SubscriptionListCubit(this.repo) : super(SubscriptionListInitial());

  Future<void> load(String dateId, bool isRenewal) async {
    emit(SubscriptionListLoading());

    try {
      final items = await repo.getSubscriptionsForDate(dateId, isRenewal);
      emit(SubscriptionListLoaded(items));
    } catch (e) {
      emit(SubscriptionListError(e.toString()));
    }
  }
}
