import 'package:flutter/material.dart';
import 'package:power_gym/features/report/data/models/model/daily_summary_model.dart';

class DailySummary extends StatelessWidget {
  const DailySummary({super.key, required this.s});

  final DailySummaryModel s;

  void _showTransactions(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تفاصيل اليوم'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: s.transactions.length,
            itemBuilder: (ctx, index) {
              final t = s.transactions[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  title: Text('عضو: ${t.memberId}'),
                  subtitle: Text(
                    'اشتراك: ${t.plan}\nطريقة الدفع: ${t.paymentMethod}',
                  ),
                  trailing: Text(
                    '${t.status == 'income' ? '+' : '-'}${t.amount}',
                    style: TextStyle(
                      color: t.status == 'income' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('اغلاق'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('الدخل'),
            const SizedBox(width: 40),
            Text('${s.income}', style: TextStyle(color: Colors.green)),
            const SizedBox(width: 50),
            const Text('الخوارج'),
            const SizedBox(width: 40),
            Text('${s.expense}', style: TextStyle(color: Colors.red)),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => _showTransactions(context),
              child: const Text('View'),
            ),
          ],
        ),
        const Divider(),
        Row(
          children: [
            const Text('total'),
            const SizedBox(width: 40),
            Text('${s.total}', style: TextStyle(color: Colors.green)),
          ],
        ),
      ],
    );
  }
}
