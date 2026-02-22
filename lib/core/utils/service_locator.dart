import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo_impl.dart';
import 'package:power_gym/features/home/data/models/repo/get_data_member_repo_impl.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/attendance_cubit.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/dashboard_cubit.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/get_data_member_cubit.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/recent_member_cubit.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/guest_visits_repo.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/guest_visits_repo_impl.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/member_subscriptions_repo.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/member_subscriptions_repo_impl.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/plans_repo.dart';
import 'package:power_gym/features/member_subscriptions/data/models/repo/plans_repo_impl.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo_impl.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/members_count_stats_cubit.dart';
import 'package:power_gym/features/payment/data/models/repo/payment_repo.dart';
import 'package:power_gym/features/payment/data/models/repo/payment_repo_impl.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/plan_and_packages/data/models/repo/plan_repo_imlp.dart';
import 'package:power_gym/features/plan_and_packages/presentation/manger/cubit/plan_cubit.dart';
import 'package:power_gym/features/report/data/models/repo/daily_report_comment_repo.dart';
import 'package:power_gym/features/report/data/models/repo/daily_report_comment_repo_impl.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_report_comment_cubit.dart';
import 'package:power_gym/features/subscriptions/data/models/repo/sub_repo_impl.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_cubit.dart';
import 'package:power_gym/features/trainers/data/models/repo/trainer_repo_impl.dart';
import 'package:power_gym/features/trainers/presentation/manger/cubit/trainer_cubit.dart';

final sl = GetIt.instance;

void setupLocator() {
  // سجل الـ Repo مرة واحدة فقط
  sl.registerLazySingleton<MemberRepoImpl>(() => MemberRepoImpl());
  sl.registerLazySingleton<AttendanceRepo>(
    () => AttendanceRepoImpl(FirebaseFirestore.instance),
  );

  // سجل Cubit الخاص بالأعضاء
  sl.registerFactory<MembersCubit>(
    () => MembersCubit(sl<MemberRepoImpl>())..loadMembers(),
  );

  // سجل Cubit الخاص بالإحصائيات
  sl.registerFactory<MembersCountStatsCubit>(
    () => MembersCountStatsCubit(
      sl<MemberRepoImpl>(),
      sl<MemberSubscriptionsRepo>(),
    )..loadStats(),
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

  sl.registerLazySingleton<MemberSubscriptionsRepo>(
    () => MemberSubscriptionsRepoImpl(),
  );

  sl.registerLazySingleton<GuestVisitsRepo>(
    () => GuestVisitsRepoImpl(FirebaseFirestore.instance),
  );
  sl.registerFactory<MemberSubscriptionCubit>(
    () => MemberSubscriptionCubit(
      sl<MemberSubscriptionsRepo>(),
      sl<PlansRepo>(),
      sl<GuestVisitsRepo>(),
    ),
  );

  sl.registerLazySingleton<PlansRepo>(() => PlansRepoImpl());
  sl.registerLazySingleton<PaymentRepo>(() => PaymentRepoImpl());
  sl.registerFactory<PaymentCubit>(
    () => PaymentCubit(sl<PaymentRepo>())..loadPayment(),
  );

  sl.registerLazySingleton<PlanRepoImpl>(
    () => PlanRepoImpl(FirebaseFirestore.instance),
  );
  sl.registerFactory<PlanCubit>(
    () => PlanCubit(sl<PlanRepoImpl>(), sl<PaymentRepo>())..loadPlan(),
  );

  sl.registerLazySingleton<GetDataMemberRepoImpl>(
    () => GetDataMemberRepoImpl(),
  );
  sl.registerFactory<GetDataMemberCubit>(
    () => GetDataMemberCubit(sl<GetDataMemberRepoImpl>())..loadData(),
  );

  sl.registerFactory<DashboardCubit>(
    () => DashboardCubit(sl<AttendanceRepo>())..loadDashboard(),
  );

  sl.registerFactory<AttendanceCubit>(
    () => AttendanceCubit(sl<AttendanceRepo>()),
  );

  sl.registerFactory<RecentMemberCubit>(
    () => RecentMemberCubit(sl<AttendanceRepo>())..loadRecent(),
  );

  sl.registerLazySingleton<DailyReportCommentRepo>(
    () => DailyReportCommentRepoImpl(FirebaseFirestore.instance),
  );
  sl.registerFactory<DailyReportCommentCubit>(
    () => DailyReportCommentCubit(sl<DailyReportCommentRepo>()),
  );
}
