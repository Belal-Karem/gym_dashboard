import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/utils/constants.dart';
import 'package:power_gym/core/widget/custom_dropdown_button_widget.dart';
import 'package:power_gym/core/widget/custom_search_widget.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_cubit.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_state.dart';

class TopSectionOfMembers extends StatelessWidget {
  const TopSectionOfMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: CustomDropdownButtonWidgetSession()),
        const SizedBox(width: 12),
        const Text('Status', style: AppStyle.style20),
        const SizedBox(width: 28),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: kprimaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomSearchWidget(
              onChanged: (value) {
                context.read<MembersCubit>().searchMembers(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownButtonWidgetSession extends StatefulWidget {
  const CustomDropdownButtonWidgetSession({super.key});

  @override
  State<CustomDropdownButtonWidgetSession> createState() =>
      _CustomDropdownButtonWidgetSessionState();
}

class _CustomDropdownButtonWidgetSessionState
    extends State<CustomDropdownButtonWidgetSession> {
  @override
  void initState() {
    super.initState();
    context.read<MembersCubit>().resetFilters();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembersCubit, MembersState>(
      builder: (context, state) {
        return CustomDropdownButtonWidget(
          items: const [
            DropdownMenuItem(value: 'all', child: Text('الكل')),
            DropdownMenuItem(value: 'نشط', child: Text('نشط')),
            DropdownMenuItem(value: 'متوقف', child: Text('متوقف')),
          ],
          onChanged: (value) {
            context.read<MembersCubit>().filterByStatus(value!);
          },
        );
      },
    );
  }
}
