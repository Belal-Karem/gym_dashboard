import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo_impl.dart';
import 'package:power_gym/features/home/data/models/repo/get_data_member_repo_impl.dart';
import 'package:power_gym/features/home/data/models/repo/notifications_repo_impl.dart';
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
import 'package:power_gym/features/peivate/data/models/repo/private_repo_imlp.dart';
import 'package:power_gym/features/peivate/presentation/manger/cubit/private_cubit.dart';
import 'package:power_gym/features/report/data/models/repo/daily_report_comment_repo.dart';
import 'package:power_gym/features/report/data/models/repo/daily_report_comment_repo_impl.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_report_comment_cubit.dart';
import 'package:power_gym/features/subscriptions/data/models/repo/sub_repo_impl.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_cubit.dart';
import 'package:power_gym/features/trainers/data/models/repo/trainer_repo_impl.dart';
import 'package:power_gym/features/trainers/presentation/manger/cubit/trainer_cubit.dart';

final sl = GetIt.instance;

void setupLocator() {
  final firestore = FirebaseFirestore.instance;

  // ── Infrastructure / shared ───────────────────────────────────────────────

  sl.registerLazySingleton<AttendanceRepo>(() => AttendanceRepoImpl(firestore));

  // ── Notifications ─────────────────────────────────────────────────────────
  // Registered so HomeViewBody no longer needs to `new` it directly.
  sl.registerLazySingleton<NotificationsRepoImpl>(
    () => NotificationsRepoImpl(),
  );

  // ── Members ───────────────────────────────────────────────────────────────
  sl.registerLazySingleton<MemberRepoImpl>(() => MemberRepoImpl());

  sl.registerFactory<MembersCubit>(
    () => MembersCubit(sl<MemberRepoImpl>())..loadMembers(),
  );

  sl.registerFactory<MembersCountStatsCubit>(
    () => MembersCountStatsCubit(
      sl<MemberRepoImpl>(),
      sl<MemberSubscriptionsRepo>(),
    )..loadStats(),
  );

  // ── Member subscriptions ──────────────────────────────────────────────────
  sl.registerLazySingleton<MemberSubscriptionsRepo>(
    () => MemberSubscriptionsRepoImpl(),
  );

  sl.registerLazySingleton<PlansRepo>(() => PlansRepoImpl());

  sl.registerLazySingleton<GuestVisitsRepo>(
    () => GuestVisitsRepoImpl(firestore),
  );

  sl.registerFactory<MemberSubscriptionCubit>(
    () => MemberSubscriptionCubit(
      sl<MemberSubscriptionsRepo>(),
      sl<PlansRepo>(),
      sl<GuestVisitsRepo>(),
    ),
  );

  // ── Subscriptions (plan catalogue) ────────────────────────────────────────
  sl.registerLazySingleton<SubRepoImpl>(() => SubRepoImpl());

  sl.registerFactory<SubCubit>(() => SubCubit(sl<SubRepoImpl>())..loadSub());

  // ── Trainers ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<TrainerRepoImpl>(() => TrainerRepoImpl());

  sl.registerFactory<TrainerCubit>(
    () => TrainerCubit(sl<TrainerRepoImpl>())..loadTrainer(),
  );

  // ── Payments ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<PaymentRepo>(() => PaymentRepoImpl());

  sl.registerLazySingleton<PaymentCubit>(
    () => PaymentCubit(sl<PaymentRepo>())..loadPayment(),
  );

  // ── Private (PT) plans ────────────────────────────────────────────────────
  sl.registerLazySingleton<PrivateRepoImpl>(() => PrivateRepoImpl(firestore));

  sl.registerFactory<PrivateCubit>(
    () => PrivateCubit(sl<PrivateRepoImpl>(), sl<PaymentRepo>())..loadPrivate(),
  );

  // ── Home / dashboard ──────────────────────────────────────────────────────
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

  // ── Daily report comments ─────────────────────────────────────────────────
  sl.registerLazySingleton<DailyReportCommentRepo>(
    () => DailyReportCommentRepoImpl(firestore),
  );

  sl.registerFactory<DailyReportCommentCubit>(
    () => DailyReportCommentCubit(sl<DailyReportCommentRepo>()),
  );
}
