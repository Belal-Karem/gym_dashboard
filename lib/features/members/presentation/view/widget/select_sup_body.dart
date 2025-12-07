import 'package:flutter/material.dart';
import 'package:power_gym/core/widget/elevated_button_to_dialog.dart';
import 'package:power_gym/core/widget/elevated_button_widget.dart';
import 'package:power_gym/features/members/presentation/view/widget/select_sup_item.dart';
import 'package:power_gym/features/subscriptions/data/models/sub_model/sub_model.dart';

class SelectSupBody extends StatefulWidget {
  const SelectSupBody({super.key, required this.subs});

  final List<SubModel> subs;

  @override
  State<SelectSupBody> createState() => _SelectSupBodyState();
}

class _SelectSupBodyState extends State<SelectSupBody> {
  int value = -1;

  @override
  Widget build(BuildContext context) {
    final sortedSubs = List<SubModel>.from(widget.subs)
      ..sort((a, b) => a.duration.compareTo(b.duration));
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'اختار الشتراك',
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
                  childAspectRatio: 1.3,
                ),
                itemCount: sortedSubs.length,
                itemBuilder: (context, index) {
                  final sub = sortedSubs[index];
                  return InkWell(
                    onTap: () {
                      if (sub.status != 'نشط') return;
                      if (!mounted) return;
                      setState(() {
                        value = index;
                      });
                    },
                    child: SelectSupItem(
                      subs: sub,
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
