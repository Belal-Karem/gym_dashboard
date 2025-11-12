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

class SelectSupBody extends StatelessWidget {
  const SelectSupBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'select supsctiption for "Ahmed Ali"',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              ElevatedButtonWidget(
                text: 'Canle',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.4,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return SelectSupItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}
