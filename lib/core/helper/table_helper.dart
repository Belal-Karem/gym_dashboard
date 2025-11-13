import 'package:flutter/material.dart';

class TableHelper {
  static DataRow buildRowsubScriptions({
    required String plan,
    required String duration,
    required String price,
    required String subs,
    String status = 'Active',
  }) {
    return DataRow(
      cells: [
        DataCell(SizedBox(width: 160, child: Center(child: Text(plan)))),
        DataCell(SizedBox(width: 140, child: Center(child: Text(duration)))),
        DataCell(SizedBox(width: 140, child: Center(child: Text(price)))),
        DataCell(SizedBox(width: 120, child: Center(child: Text(subs)))),
        DataCell(
          SizedBox(
            width: 140,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status, style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static DataRow buildRowtrainer({
    required String name,
    required String mobile,
    required String clients,
    required String subs,
    String status = 'Active',
  }) {
    return DataRow(
      cells: [
        DataCell(Center(child: Text(name))),
        DataCell(Center(child: Text(mobile))),
        DataCell(
          Center(
            child: Row(
              children: [
                Text(clients),
                SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff18191E),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text('View'),
                  ),
                ),
              ],
            ),
          ),
        ),
        DataCell(Center(child: Text(subs))),
        DataCell(
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: status == 'Active'
                    ? const Color(0xff245945)
                    : Colors.redAccent,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(status, style: const TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

  static TableRow buildDataRow({required List<Widget> cells, Color? color}) {
    return TableRow(
      decoration: BoxDecoration(color: color ?? Colors.transparent),
      children: cells,
    );
  }

  static TableRow buildHeaderRow(List<Widget> titles) {
    return TableRow(children: titles);
  }
}
