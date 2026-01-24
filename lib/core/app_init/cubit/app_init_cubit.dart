import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/app_init/cubit/app_init_state.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/member_subscriptions_repo.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo.dart';

// class AppInitCubit extends Cubit<AppInitState> {
//   final MemberRepo memberRepo;
//   final MemberSubscriptionsRepo subscriptionsRepo;

//   AppInitCubit(this.memberRepo, this.subscriptionsRepo)
//     : super(AppInitLoading());

//   Future<void> init() async {
//     try {
//       await Future.wait([memberRepo.preload(), subscriptionsRepo.preload()]);

//       emit(AppInitReady());
//     } catch (e) {
//       emit(AppInitError(e.toString()));
//     }
//   }
// }
