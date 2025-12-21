import 'package:flutter/material.dart';
import 'package:power_gym/core/helper/date_helper.dart';
import 'package:power_gym/core/helper/table_helper.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/core/widget/table_cell_widget.dart';
import 'package:power_gym/features/payment/data/models/model/payment_model.dart';

class PaymentDataTaple extends StatelessWidget {
  const PaymentDataTaple({super.key, required this.payment});

  final List<PaymentModel> payment;

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      padding: 0,
      child: SingleChildScrollView(
        child: Table(
          border: TableBorder(
            horizontalInside: BorderSide(
              color: Colors.white.withOpacity(0.15),
              width: 0.5,
            ),
          ),
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1.2),
          },
          children: [
            TableHelper.buildHeaderRow([
              TableHeaderCellWidget('الاسم/النوع'),
              TableHeaderCellWidget('الخطه'),
              TableHeaderCellWidget('المدفوع'),
              TableHeaderCellWidget('وقت الدفع'),
              TableHeaderCellWidget('طريق الدفع'),
            ]),

            ...payment.map(
              (payment) => TableHelper.buildDataRow(
                color: payment.status == 'expense'
                    ? Colors.red.withAlpha(20)
                    : Colors.transparent,
                cells: [
                  TableCellWidget(payment.type),
                  TableCellWidget(payment.plan),
                  TableCellWidget(payment.paid),
                  TableCellWidget(
                    DateHelper.formatPaymentDate(payment.date.toString()),
                  ),
                  TableCellWidget(
                    payment.paymentMethod,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
