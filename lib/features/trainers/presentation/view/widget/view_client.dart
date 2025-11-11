import 'package:flutter/material.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/utils/constants.dart';

class ViewClient extends StatelessWidget {
  const ViewClient({super.key});
  final List<String> usernames = const [
    'Ahmed',
    'Mohamed',
    'Ibrahim',
    'Omar',
    'Youssef',
    'Mostafa',
    'Khaled',
    'Mahmoud',
    'Walid',
    'Sami',
    'Fady',
    'Karim',
    'Ali',
    'Tamer',
    'Nader',
    'Essam',
    'Sherif',
    'Gamal',
    'Wael',
    'Mina',
    'Rami',
    'Hossam',
    'Taha',
    'Bassem',
    'Emad',
    'Samir',
    'Ayman',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kprimaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Expanded(
          child: Column(
            children: [
              Text('معلومات العضو', style: AppStyle.style20W500),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return ViewClientItem();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewClientItem extends StatelessWidget {
  const ViewClientItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: double.minPositive,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text('belal'),
      ),
    );
  }
}
