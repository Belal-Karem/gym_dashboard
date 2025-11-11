// import 'package:flutter/material.dart';
// import 'package:power_gym/core/helper/table_helper.dart';
// import 'package:power_gym/core/widget/custom_container_statistics.dart';
// import 'package:power_gym/core/widget/table_cell_widget.dart';

// class PaymentBody extends StatelessWidget {
//   const PaymentBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomContainerStatistics(
//       child: SingleChildScrollView(
//         child: Table(
//           border: TableBorder(
//             horizontalInside: BorderSide(
//               color: Colors.white.withOpacity(0.15),
//               width: 0.5,
//             ),
//           ),
//           columnWidths: const {
//             0: FlexColumnWidth(1.2),
//             1: FlexColumnWidth(1),
//             2: FlexColumnWidth(1),
//             3: FlexColumnWidth(1),
//             4: FlexColumnWidth(1.2),
//           },
//           children: [
//             TableHelper.buildHeaderRow([
//               TableHeaderCellWidget('Plan Name'),
//               TableHeaderCellWidget('Duration'),
//               TableHeaderCellWidget('Price'),
//               TableHeaderCellWidget('Subscribers'),
//               TableHeaderCellWidget('Status'),
//             ]),

//             TableHelper.buildDataRow(
//               cells: [
//                 TableCellWidget('One Month'),
//                 TableCellWidget('30 Days'),
//                 TableCellWidget('500 EGP'),
//                 TableCellWidget('35'),
//                 TableCellWidget(
//                   'Active',
//                   style: const TextStyle(
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
