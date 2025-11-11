import 'package:flutter/material.dart';
import 'package:power_gym/model/list_title_overview_model.dart';

class ListTitleItem extends StatelessWidget {
  const ListTitleItem({super.key, required this.listTitleOverviewModel});

  final ListTitleOverviewModel listTitleOverviewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: ListTile(
        titleTextStyle: TextStyle(fontSize: 20),
        leadingAndTrailingTextStyle: TextStyle(fontSize: 18),
        title: Text(listTitleOverviewModel.text),
        leading: Icon(listTitleOverviewModel.icon),
        trailing: Text(listTitleOverviewModel.data),
      ),
    );
  }
}
