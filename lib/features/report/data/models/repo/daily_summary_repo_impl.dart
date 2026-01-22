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
    List<DailyTransaction> transactions = [];

    final paymentsSnap = await firestore
        .collection(kpaymentCollections)
        .where('dateId', isEqualTo: dateId)
        .get();

    for (final doc in paymentsSnap.docs) {
      final data = doc.data();
      final amount = double.tryParse(data['paid'].toString()) ?? 0;
      final status = data['status'] ?? 'income';
      final memberId = data['memberId'] ?? '';
      final plan = data['plan'] ?? '';
      final paymentMethod = data['payment method'] ?? '';
      final date = (data['date'] as Timestamp?)?.toDate() ?? DateTime.now();

      // جلب اسم العضو من collection الأعضاء
      String memberName = memberId; // افتراضي لو ما لقيناش
      if (memberId.isNotEmpty) {
        final memberDoc = await firestore
            .collection(kMemberCollections)
            .doc(memberId)
            .get();
        if (memberDoc.exists) {
          memberName = memberDoc.data()?['name'] ?? memberId;
        }
      }

      transactions.add(
        DailyTransaction(
          id: doc.id,
          memberId: memberName, // نستخدم الاسم بدل ال ID
          plan: plan,
          paymentMethod: paymentMethod,
          amount: amount,
          status: status,
          date: date,
        ),
      );

      if (status == 'income') {
        income += amount;
      } else if (status == 'expense') {
        expense += amount;
      }
    }

    return DailySummaryModel(
      income: income,
      expense: expense,
      transactions: transactions,
    );
  }
}
