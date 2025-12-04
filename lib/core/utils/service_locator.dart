import 'package:get_it/get_it.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo_impl.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/subscriptions/data/models/repo/sub_repo_impl.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_cubit.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Repository
  sl.registerLazySingleton<MemberRepoImpl>(() => MemberRepoImpl());

  // Cubit
  sl.registerFactory<MembersCubit>(
    () => MembersCubit(sl<MemberRepoImpl>())..loadMembers(),
  );

  // Repository
  sl.registerLazySingleton<SubRepoImpl>(() => SubRepoImpl());

  // Cubit
  sl.registerFactory<SubCubit>(() => SubCubit(sl<SubRepoImpl>())..loadSub());
}
