import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/custom_container_statistics.dart';
import 'package:power_gym/features/home/presentation/view/widget/custom_dot.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerStatistics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              children: [
                Text(
                  'إشعارات',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: ShapeDecoration(
                    color: Color(0xff2A2B30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete_outlined, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          CustomNotificationsInt(),
        ],
      ),
    );
  }
}
