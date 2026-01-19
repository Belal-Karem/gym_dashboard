import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

class MemberSubWithPlan {
  final MemberSubscriptionModel subscription;
  final SubModel plan;

  MemberSubWithPlan({required this.subscription, required this.plan});
}
