class DailySummaryModel {
  final int newSubscriptions;
  final int renewals;
  final double income;
  final double expense;

  const DailySummaryModel({
    required this.newSubscriptions,
    required this.renewals,
    required this.income,
    required this.expense,
  });

  double get total => income - expense;
}
