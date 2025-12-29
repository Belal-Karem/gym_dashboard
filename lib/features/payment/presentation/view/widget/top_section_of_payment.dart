import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/core/utils/app_style.dart';
import 'package:power_gym/core/utils/constants.dart';
import 'package:power_gym/core/widget/custom_dropdown_button_widget.dart';
import 'package:power_gym/core/widget/custom_search_widget.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_cubit.dart';
import 'package:power_gym/features/payment/presentation/manger/cubit/payment_state.dart';

class TopSectionOfPayment extends StatelessWidget {
  const TopSectionOfPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: CustomDropdownButtonWidgetSession()),
        SizedBox(width: 12),
        Text('طريقة الدفع', style: AppStyle.style20),
        SizedBox(width: 28),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: kprimaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomSearchWidget(
              onChanged: (value) {
                context.read<PaymentCubit>().searchMembers(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownButtonWidgetSession extends StatefulWidget {
  const CustomDropdownButtonWidgetSession({super.key});

  @override
  State<CustomDropdownButtonWidgetSession> createState() =>
      _CustomDropdownButtonWidgetSessionState();
}

class _CustomDropdownButtonWidgetSessionState
    extends State<CustomDropdownButtonWidgetSession> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().resetFilters();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return CustomDropdownButtonWidget(
          items: const [
            DropdownMenuItem(value: 'all', child: Text('الكل')),
            DropdownMenuItem(value: 'نقدي', child: Text('نقدي')),
            DropdownMenuItem(value: 'محفظه', child: Text('محفظه')),
            DropdownMenuItem(value: 'فيزا', child: Text('فيزا')),
            DropdownMenuItem(value: 'إنستاباي', child: Text('إنستاباي')),
          ],
          onChanged: (value) {
            context.read<PaymentCubit>().filterByStatus(value!);
          },
        );
      },
    );
  }
}
