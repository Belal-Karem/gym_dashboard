import 'package:flutter/material.dart';
import 'package:power_gym/model/show_dialog_data_member_Info_model.dart';

class ListTileSup extends StatelessWidget {
  const ListTileSup({
    super.key,
    required this.showDialogDataMemberInfoModel,
    this.styleTrailing,
    this.styleTitle,
  });

  final ShowDialogDataMemberInfoModel showDialogDataMemberInfoModel;
  final TextStyle? styleTrailing;
  final TextStyle? styleTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        showDialogDataMemberInfoModel.title,
        style: styleTitle ?? TextStyle(fontSize: 20),
      ),
      trailing: Text(
        showDialogDataMemberInfoModel.trailing,
        style:
            styleTrailing ??
            TextStyle(fontSize: 20, color: Colors.white.withAlpha(100)),
      ),
    );
  }
}
