import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:power_gym/core/utils/app_router.dart';
import 'package:power_gym/core/utils/service_locator.dart';
import 'package:power_gym/features/home/data/models/repo/attendance_repo.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/attendance_cubit.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/dashboard_cubit.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/get_data_member_cubit.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/recent_member_cubit.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/members_count_stats_cubit.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/plan_and_packages/presentation/manger/cubit/plan_cubit.dart';
import 'package:power_gym/features/report/data/models/repo/daily_attendance_repo_impl.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_attendance_cubit.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/daily_report_comment_cubit.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/report_filter_cubit.dart';
import 'package:power_gym/features/subscriptions/presentation/manger/cubit/sub_cubit.dart';
import 'package:power_gym/features/trainers/presentation/manger/cubit/trainer_cubit.dart';
import 'package:power_gym/firebase_options.dart';
import 'package:power_gym/generated/l10n.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    setWindowTitle('MyApp');
    // setWindowMinSize(const Size(1800, 770)); علشات اثبت حجم الشاشه
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MembersCubit>(create: (_) => sl<MembersCubit>()),
        BlocProvider<SubCubit>(create: (_) => sl<SubCubit>()),
        BlocProvider<TrainerCubit>(create: (_) => sl<TrainerCubit>()),
        BlocProvider<MemberSubscriptionCubit>(
          create: (_) => sl<MemberSubscriptionCubit>(),
        ),
        BlocProvider<PaymentCubit>(create: (_) => sl<PaymentCubit>()),
        BlocProvider<PlanCubit>(create: (_) => sl<PlanCubit>()),
        BlocProvider<GetDataMemberCubit>(
          create: (_) => sl<GetDataMemberCubit>(),
        ),
        BlocProvider(create: (_) => sl<DashboardCubit>()),
        BlocProvider(create: (_) => sl<RecentMemberCubit>()),
        BlocProvider(
          create: (_) => AttendanceCubit(sl<AttendanceRepo>()), // أو repo مباشر
        ),
        BlocProvider(create: (_) => ReportFilterCubit()),
        BlocProvider(
          create: (_) => DailyAttendanceCubit(
            DailyAttendanceRepoImpl(FirebaseFirestore.instance),
          ),
        ),
        BlocProvider(create: (_) => sl<DailyReportCommentCubit>()),
        BlocProvider(create: (context) => sl<MembersCountStatsCubit>()),
      ],
      child: MaterialApp.router(
        locale: Locale('ar'),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xff131419),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
