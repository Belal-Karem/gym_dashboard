import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/report/data/models/model/daily_summary_model.dart';
import 'package:power_gym/features/report/data/models/repo/daily_summary_repo.dart';

class DailySummaryRepoImpl implements DailySummaryRepo {
  final FirebaseFirestore firestore;

  DailySummaryRepoImpl(this.firestore);

  @override
  Future<DailySummaryModel> getDailySummary(String dateId) async {
    double income = 0;
    double expense = 0;
    int newSubs = 0;
    int renewals = 0;

    /// Payments
    final paymentsSnap = await firestore
        .collection(kpaymentCollections)
        .where('dateId', isEqualTo: dateId)
        .get();

    for (final doc in paymentsSnap.docs) {
      final data = doc.data();
      final amount = double.tryParse(data['paid'].toString()) ?? 0;

      if (data['status'] == 'income') {
        income += amount;
      } else if (data['status'] == 'expense') {
        expense += amount;
      }
    }

    /// Subscriptions
    final subsSnap = await firestore
        .collection(kmembersubscriptionsCollections)
        .where('dateId', isEqualTo: dateId)
        .get();

    for (final doc in subsSnap.docs) {
      final data = doc.data();
      if (data['isRenewal'] == true) {
        renewals++;
      } else {
        newSubs++;
      }
    }

    return DailySummaryModel(
      newSubscriptions: newSubs,
      renewals: renewals,
      income: income,
      expense: expense,
    );
  }
}
