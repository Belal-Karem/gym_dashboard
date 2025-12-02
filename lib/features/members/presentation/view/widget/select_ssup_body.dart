import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/elevated_button_to_dialog.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/features/members/presentation/view/widget/select_sup_item.dart';

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
                const Text(
                  'اختر الاشتراك لـ "أحمد علي"',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                ElevatedButtonWidget(
                  text: 'حفظ',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 10),
                ElevatedButtonToDialog(
                  text: 'يلغي',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1,
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
