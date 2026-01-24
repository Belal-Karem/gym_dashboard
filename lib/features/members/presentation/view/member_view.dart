import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/utils/service_locator.dart';
import 'package:power_gym/core/widget/gradient_scaffold.dart';
import 'package:power_gym/core/widget/logo_and_name.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/members_count_stats_cubit.dart';
import 'package:power_gym/features/members/presentation/view/widget/member_of_men_and_women.dart';
import 'package:power_gym/features/members/presentation/view/widget/member_view_body.dart';

class MemberView extends StatelessWidget {
  const MemberView({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          Row(
            children: [
              LogoAndName(),
              const SizedBox(width: 200),
              BlocProvider(
                create: (context) => sl<MembersCountStatsCubit>(),
                child: const MembersStatisticsRow(),
              ),
            ],
          ),
          Expanded(child: const MemberViewBody()),
        ],
      ),
    );
  }
}
