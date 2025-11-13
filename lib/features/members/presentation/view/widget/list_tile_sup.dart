import 'package:flutter/material.dart';
import 'package:power_gym/model/show_dialog_data_member_Info_model.dart';

class ListTileSup extends StatelessWidget {
  const ListTileSup({super.key, required this.showDialogDataMemberInfoModel});

  final ShowDialogDataMemberInfoModel showDialogDataMemberInfoModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        showDialogDataMemberInfoModel.title,
        style: TextStyle(fontSize: 20),
      ),
      trailing: Text(
        showDialogDataMemberInfoModel.trailing,
        style: TextStyle(fontSize: 20, color: Colors.white.withAlpha(100)),
      ),
    );
  }
}
