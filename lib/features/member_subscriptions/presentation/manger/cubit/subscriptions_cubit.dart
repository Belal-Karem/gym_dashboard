import 'package:bloc/bloc.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/member_subscriptions_repo.dart';

part 'subscriptions_state.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  final MemberSubscriptionsRepo repo;

  SubscriptionsCubit(this.repo) : super(SubscriptionsInitial());

  Future<void> addSubscription(MemberSubscriptionModel model) async {
    emit(SubscriptionsLoading());
    final result = await repo.addMemberSubscription(model);
    result.fold(
      (failure) => emit(SubscriptionsFailure(failure.message)),
      (_) => emit(SubscriptionAdded()),
    );
  }

  Future<void> getMemberSubscriptions(String memberId) async {
    emit(SubscriptionsLoading());
    final result = await repo.getSubscriptionsByMember(memberId);
    result.fold(
      (failure) => emit(SubscriptionsFailure(failure.message)),
      (list) => emit(SubscriptionsSuccess(list)),
    );
  }
}
