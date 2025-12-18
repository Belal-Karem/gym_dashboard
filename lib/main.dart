import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:power_gym/core/utils/app_router.dart';
import 'package:power_gym/core/utils/service_locator.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/attendance_cubit/attendance_cubit.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/members_count_for_dashboard_cubit/members_count_for_dashboard_cubit.dart';
import 'package:power_gym/features/home/presentation/manger/cubit/today_attendance_cubit/today_attendance_cubit.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/plan_and_packages/presentation/manger/cubit/plan_cubit.dart';
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
        BlocProvider<SubscriptionsCubit>(
          create: (_) => sl<SubscriptionsCubit>(),
        ),
        BlocProvider<PaymentCubit>(create: (_) => sl<PaymentCubit>()),
        BlocProvider<PlanCubit>(create: (_) => sl<PlanCubit>()),
        BlocProvider<MembersCountForDashboardCubit>(
          create: (_) => sl<MembersCountForDashboardCubit>(),
        ),
        BlocProvider<AttendanceCubit>(create: (_) => sl<AttendanceCubit>()),
        BlocProvider<TodayAttendanceCubit>(
          create: (_) => sl<TodayAttendanceCubit>(),
        ),
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
