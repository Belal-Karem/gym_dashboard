import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/member_subscriptions_repo.dart';
import 'package:power_gym/features/members/data/models/member_model/members_count_mode.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/members_count_state_state.dart';

class MembersCountStatsCubit extends Cubit<MembersCountStatsState> {
  final MemberRepo memberRepo;
  final MemberSubscriptionsRepo subscriptionsRepo;

  StreamSubscription? _membersSubscription;

  MembersCountStatsCubit(this.memberRepo, this.subscriptionsRepo)
    : super(MembersCountStatsInitial());

  void loadStats() async {
    emit(MembersCountStatsLoading());

    final membersResult = await memberRepo.getAllMembers();

    membersResult.fold(
      (failure) {
        if (!isClosed) emit(MembersCountStatsError(failure.message));
      },
      (membersStream) {
        _membersSubscription = membersStream.listen(
          (members) async {
            int men = 0;
            int women = 0;
            int children = 0;
            int active = 0;
            int expired = 0;

            for (final member in members) {
              // النوع
              switch (member.gender.toLowerCase()) {
                case 'ذكر':
                  men++;
                  break;
                case 'أنثى':
                  women++;
                  break;
                case 'طفل':
                  children++;
                  break;
              }

              // الاشتراك
              final subResult = await subscriptionsRepo
                  .getSubscriptionsByMember(member.id);

              subResult.fold((_) => expired++, (subs) {
                final hasActive = subs.any(
                  (s) => s.status == SubscriptionStatus.active,
                );

                if (hasActive) {
                  active++;
                } else {
                  expired++;
                }
              });
            }

            if (!isClosed) {
              emit(
                MembersCountStatsLoaded(
                  MembersCountMode(
                    men: men,
                    women: women,
                    children: children,
                    active: active,
                    expired: expired,
                  ),
                ),
              );
            }
          },
          onError: (e) {
            if (!isClosed) emit(MembersCountStatsError(e.toString()));
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    _membersSubscription?.cancel();
    return super.close();
  }
}
