import 'package:go_router/go_router.dart';
import 'package:power_gym/features/home/presentation/view/home_view.dart';
import 'package:power_gym/features/members/presentation/view/member_view.dart';
import 'package:power_gym/features/payment/presentation/view/payment_view.dart';
import 'package:power_gym/features/plan_and_packages/presentation/view/plan_view.dart';
import 'package:power_gym/features/report/presentation/view/report_view.dart';
import 'package:power_gym/features/settings/presentation/view/setting_view.dart';
import 'package:power_gym/features/subscriptions/presentation/view/subscriptions_view.dart';
import 'package:power_gym/features/trainers/presentation/view/trainer_view.dart';

abstract class AppRouter {
  static const kpaymentview = '/payment_view';
  static const ktrainerview = '/trainer_view';
  static const kmemberview = '/member_view';
  static const khomeview = '/home_view';
  static const kplanview = '/plan_view';
  static const kreportview = '/report_view';
  static const ksubscriptionsview = '/subscriptions_view';
  static const ksettingview = '/setting_view';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeView()),
      GoRoute(path: khomeview, builder: (context, state) => const HomeView()),
      GoRoute(
        path: kmemberview,
        builder: (context, state) => const MemberView(),
      ),
      GoRoute(
        path: ksubscriptionsview,
        builder: (context, state) => const SubscriptionsView(),
      ),
      GoRoute(
        path: ktrainerview,
        builder: (context, state) => const TrainerView(),
      ),
      GoRoute(
        path: kpaymentview,
        builder: (context, state) => const PaymentView(),
      ),
      GoRoute(path: kplanview, builder: (context, state) => const PlanView()),
      GoRoute(
        path: kreportview,
        builder: (context, state) => const ReportView(),
      ),
      GoRoute(
        path: ksettingview,
        builder: (context, state) => const SettingView(),
      ),
    ],
  );
}
