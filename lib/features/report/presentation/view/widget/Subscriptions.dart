import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:power_gym/features/report/data/models/repo/subscription_report_repo.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/subscription_list_cubit.dart';
import 'package:power_gym/features/report/presentation/manger/cubit/subscription_list_state.dart';

class Subscriptions extends StatelessWidget {
  final int newSubsCount;
  final int renewalsCount;
  final DateTime date;
  final SubscriptionReportRepo repo;

  const Subscriptions({
    super.key,
    required this.newSubsCount,
    required this.renewalsCount,
    required this.date,
    required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _row(
          context: context,
          title: 'الاشتراكات الجديدة',
          count: newSubsCount,
          isRenewal: false,
        ),
        const Divider(),
        _row(
          context: context,
          title: 'التجديدات',
          count: renewalsCount,
          isRenewal: true,
        ),
      ],
    );
  }

  Widget _row({
    required BuildContext context,
    required String title,
    required int count,
    required bool isRenewal,
  }) {
    return Row(
      children: [
        Text(title),
        const SizedBox(width: 40),
        Text(count.toString()),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: count == 0
              ? null
              : () => _openDialog(context, title, isRenewal, date, repo),
          child: const Text('View'),
        ),
      ],
    );
  }
}

void _openDialog(
  BuildContext context,
  String title,
  bool isRenewal,
  DateTime date,
  SubscriptionReportRepo repo,
) {
  final cubit = SubscriptionListCubit(repo);

  final dateId = DateFormat('yyyy-MM-dd', 'en').format(date);
  cubit.load(dateId, isRenewal);

  showDialog(
    context: context,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: SubscriptionDetailsDialog(title: title),
    ),
  );
}

class SubscriptionDetailsDialog extends StatelessWidget {
  final String title;

  const SubscriptionDetailsDialog({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: double.maxFinite,
        child: BlocBuilder<SubscriptionListCubit, SubscriptionListState>(
          builder: (context, state) {
            if (state is SubscriptionListLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SubscriptionListLoaded) {
              if (state.items.isEmpty) {
                return const Text('لا يوجد بيانات');
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.items.length,
                itemBuilder: (_, index) {
                  final item = state.items[index];

                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(item.memberName),
                    subtitle: Text(item.memberPhone),
                    trailing: Text(item.isRenewal ? 'تجديد' : 'جديد'),
                  );
                },
              );
            }

            if (state is SubscriptionListError) {
              return Text(state.message);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إغلاق'),
        ),
      ],
    );
  }
}
