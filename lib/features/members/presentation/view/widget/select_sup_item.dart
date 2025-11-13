import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/members/presentation/view/widget/list_tile_sup.dart';
import 'package:power_gym/model/show_dialog_data_member_Info_model.dart';

class SelectSupItem extends StatelessWidget {
  const SelectSupItem({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      padding: 0,
      child: Column(
        children: [
          Row(
            children: [
              Text('3 أشهر', style: TextStyle(fontSize: 30)),
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
          Divider(color: Colors.black),
          ListTileSup(
            showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
              title: 'مدة',
              trailing: '90 يومًا',
            ),
          ),
          ListTileSup(
            showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
              title: 'تاريخ البدء',
              trailing: '12 نوفمبر 2024',
            ),
          ),
          ListTileSup(
            showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
              title: 'تاريخ الانتهاء',
              trailing: '10 فبراير 2025',
            ),
          ),
          ListTileSup(
            showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
              title: 'دعوة',
              trailing: '8',
            ),
          ),
          ListTileSup(
            showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
              title: 'سعر',
              trailing: '1300',
            ),
          ),
        ],
      ),
    );
  }
}
