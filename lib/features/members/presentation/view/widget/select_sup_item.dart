import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/members/presentation/view/widget/list_tile_sup.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';
import 'package:power_gym/model/show_dialog_data_member_Info_model.dart';

class SelectSupItem extends StatelessWidget {
  const SelectSupItem({super.key, required this.isActive, required this.subs});

  final bool isActive;
  final SubModel subs;

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      padding: 0,
      child: Column(
        children: [
          Row(
            children: [
              Text(subs.type, style: TextStyle(fontSize: 30)),
              Spacer(),
              isActive
                  ? Container(
                      height: 30,
                      width: 30,
                      decoration: ShapeDecoration(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(20),
                        ),
                      ),
                      child: Icon(Icons.check),
                    )
                  : Container(),
            ],
          ),
          const Divider(color: Colors.black),
          ListTileSup(
            showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
              title: 'مدة',
              trailing: subs.durationDays.toString(),
            ),
          ),
          ListTileSup(
            showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
              title: 'دعوة',
              trailing: subs.invitationCount.toString(),
            ),
          ),
          ListTileSup(
            showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
              title: 'تجميد',
              trailing: subs.freezeDays.toString(),
            ),
          ),

          ListTileSup(
            showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
              title: 'حاله',
              trailing: subs.status,
            ),
            styleTrailing: subs.status == 'نشط'
                ? TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )
                : TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
          ),
          const Divider(color: Colors.grey),
          ListTileSup(
            styleTitle: TextStyle(fontSize: 30, color: Colors.white),
            styleTrailing: TextStyle(fontSize: 30, color: Colors.white),
            showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
              title: 'سعر',
              trailing: subs.price.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
