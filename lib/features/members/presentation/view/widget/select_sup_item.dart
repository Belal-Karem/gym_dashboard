import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/members/presentation/view/widget/list_tile_sup.dart';
import 'package:power_gym/model/show_dialog_data_member_Info_model.dart';

class SelectSupItem extends StatelessWidget {
  const SelectSupItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      padding: 10,
      child: Column(
        children: [
          Text('3 month'),
          ListTileSup(
            showDialogDataMemberInfoModel: ShowDialogDataMemberInfoModel(
              title: 'Duration',
              trailing: '90 days',
            ),
          ),
        ],
      ),
    );
  }
}
