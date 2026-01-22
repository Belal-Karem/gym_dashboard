class DailyTransaction {
  final String id;
  final String memberId;
  final String plan;
  final String paymentMethod;
  final double amount;
  final String status; // 'income' or 'expense'
  final DateTime date;

  DailyTransaction({
    required this.id,
    required this.memberId,
    required this.plan,
    required this.paymentMethod,
    required this.amount,
    required this.status,
    required this.date,
  });
}

class DailySummaryModel {
  final double income;
  final double expense;
  final List<DailyTransaction> transactions;

  const DailySummaryModel({
    required this.income,
    required this.expense,
    required this.transactions,
  });

  double get total => income - expense;
}
