import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/features/members/presentation/view/widget/select_sup_item.dart';

class SelectSupView extends StatelessWidget {
  const SelectSupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/image/power-house-gym-gudi-malkapur-hyderabad-gyms-16vu3c2eru-removebg-preview.png',
                height: 120,
                width: 120,
              ),
              Text('Power House Gym', style: TextStyle(fontSize: 20)),
            ],
          ),
          SelectSupBody(),
        ],
      ),
    );
  }
}

class SelectSupBody extends StatefulWidget {
  const SelectSupBody({super.key});

  @override
  State<SelectSupBody> createState() => _SelectSupBodyState();
}

class _SelectSupBodyState extends State<SelectSupBody> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'اختر الاشتراك لـ "أحمد علي"',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                Spacer(),
                ElevatedButtonWidget(
                  text: 'يلغي',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.2,
                ),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (!mounted) return;
                      setState(() {
                        value = index;
                      });
                    },
                    child: SelectSupItem(
                      isActive: value == index ? true : false,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
