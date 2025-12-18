import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo_impl%20.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/attendance_cubit/attendance_cubit.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/members_count_for_dashboard_cubit/members_count_for_dashboard_cubit.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/today_attendance_cubit/today_attendance_cubit.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/member_subscriptions_repo.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/member_subscriptions_repo_impl.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo_impl.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/members_count_cubit.dart';
import 'package:power_gym/features/payment/data/models/repo/payment_repo.dart';
import 'package:power_gym/features/payment/data/models/repo/payment_repo_impl.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/plan_and_packages/data/models/repo/plan_repo.dart';
import 'package:power_gym/features/plan_and_packages/data/models/repo/plan_repo_imlp.dart';
import 'package:power_gym/features/plan_and_packages/presentation/manger/cubit/plan_cubit.dart';
import 'package:power_gym/features/subscriptions/data/models/repo/sub_repo.dart';
import 'package:power_gym/features/subscriptions/data/models/repo/sub_repo_impl.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_cubit.dart';
import 'package:power_gym/features/trainers/data/models/repo/trainer_repo.dart';
import 'package:power_gym/features/trainers/data/models/repo/trainer_repo_impl.dart';
import 'package:power_gym/features/trainers/presentation/manger/cubit/trainer_cubit.dart';

final sl = GetIt.instance;

void setupLocator() {
  // ================= Repositories =================
  sl.registerLazySingleton<MemberRepo>(() => MemberRepoImpl());
  sl.registerLazySingleton<SubRepo>(() => SubRepoImpl());
  sl.registerLazySingleton<TrainerRepo>(() => TrainerRepoImpl());
  sl.registerLazySingleton<MemberSubscriptionsRepo>(
    () => MemberSubscriptionsRepoImpl(),
  );
  sl.registerLazySingleton<PaymentRepo>(() => PaymentRepoImpl());
  sl.registerLazySingleton<PlanRepo>(() => PlanRepoImpl());
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<AttendanceRepo>(
    () => AttendanceRepoImpl(sl<FirebaseFirestore>()),
  );

  // ================= Cubits =================
  sl.registerFactory<MembersCubit>(
    () => MembersCubit(sl<MemberRepo>())..loadMembers(),
  );

  sl.registerFactory<MembersCountStatsCubit>(
    () => MembersCountStatsCubit(sl<MemberRepo>())..loadStats(),
  );

  sl.registerFactory<MembersCountForDashboardCubit>(
    () => MembersCountForDashboardCubit(sl<MemberRepo>())..loadCount(),
  );

  sl.registerFactory<SubCubit>(() => SubCubit(sl<SubRepo>())..loadSub());

  sl.registerFactory<TrainerCubit>(
    () => TrainerCubit(sl<TrainerRepo>())..loadTrainer(),
  );

  sl.registerFactory<SubscriptionsCubit>(
    () => SubscriptionsCubit(sl<MemberSubscriptionsRepo>()),
  );

  sl.registerFactory<PaymentCubit>(
    () => PaymentCubit(sl<PaymentRepo>())..loadPayment(),
  );

  sl.registerFactory<PlanCubit>(() => PlanCubit(sl<PlanRepo>())..loadPlan());
  sl.registerFactory(() => AttendanceCubit(sl()));

  sl.registerFactory(() => TodayAttendanceCubit(sl()));
}
