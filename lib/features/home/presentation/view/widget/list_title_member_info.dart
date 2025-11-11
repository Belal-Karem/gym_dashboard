import 'package:flutter/material.dart';
import 'package:power_gym/model/show_dialog_data_member_Info_model.dart';

class ListTitleMemberInfo extends StatelessWidget {
  const ListTitleMemberInfo({
    super.key,
    required this.showDialogDataMemberInfoModel,
    this.leadingAndTrailingTextStyle,
  });

  final ShowDialogDataMemberInfoModel showDialogDataMemberInfoModel;
  final TextStyle? leadingAndTrailingTextStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: ListTile(
        titleTextStyle: TextStyle(fontSize: 20),
        leadingAndTrailingTextStyle:
            leadingAndTrailingTextStyle ??
            TextStyle(fontSize: 20, color: Colors.white.withAlpha(180)),
        title: Text('${showDialogDataMemberInfoModel.title}:'),
        trailing: Text(showDialogDataMemberInfoModel.trailing),
      ),
    );
  }
}
