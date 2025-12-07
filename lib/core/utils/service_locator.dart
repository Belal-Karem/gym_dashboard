import 'package:get_it/get_it.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo_impl.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/members_count_cubit.dart';
import 'package:power_gym/features/subscriptions/data/models/repo/sub_repo_impl.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_cubit.dart';
import 'package:power_gym/features/trainers/data/models/repo/trainer_repo_impl.dart';
import 'package:power_gym/features/trainers/presentation/manger/cubit/trainer_cubit.dart';

final sl = GetIt.instance;

void setupLocator() {
  // سجل الـ Repo مرة واحدة فقط
  sl.registerLazySingleton<MemberRepoImpl>(() => MemberRepoImpl());

  // سجل Cubit الخاص بالأعضاء
  sl.registerFactory<MembersCubit>(
    () => MembersCubit(sl<MemberRepoImpl>())..loadMembers(),
  );

  // سجل Cubit الخاص بالإحصائيات
  sl.registerFactory<MembersCountStatsCubit>(
    () => MembersCountStatsCubit(sl<MemberRepoImpl>())..loadStats(),
  );
  // Repository
  sl.registerLazySingleton<SubRepoImpl>(() => SubRepoImpl());

  // Cubit
  sl.registerFactory<SubCubit>(() => SubCubit(sl<SubRepoImpl>())..loadSub());

  // Repository
  sl.registerLazySingleton<TrainerRepoImpl>(() => TrainerRepoImpl());

  // Cubit
  sl.registerFactory<TrainerCubit>(
    () => TrainerCubit(sl<TrainerRepoImpl>())..loadTrainer(),
  );
}
