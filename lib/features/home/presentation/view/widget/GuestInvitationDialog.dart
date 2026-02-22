import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:power_gym/features/member_subscriptions/data/models/model/member_sub_model.dart';
import 'package:power_gym/features/member_subscriptions/presentation/manger/cubit/subscriptions_cubit.dart';

class GuestInvitationDialog extends StatefulWidget {
  final MemberSubscriptionModel subscription;

  const GuestInvitationDialog({super.key, required this.subscription});

  @override
  State<GuestInvitationDialog> createState() => _GuestInvitationDialogState();
}

class _GuestInvitationDialogState extends State<GuestInvitationDialog> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final subscription = widget.subscription;
    final remainingInvitations =
        subscription.totalInvitations - subscription.usedInvitations;

    return AlertDialog(
      title: const Text('دعوة مرافق'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'اسم الضيف'),
          ),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: 'رقم الموبايل (اختياري)',
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 10),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Text('عدد الدعوات المتبقية: $remainingInvitations'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: isLoading || remainingInvitations <= 0
              ? null
              : () async {
                  final name = nameController.text.trim();
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('من فضلك أدخل اسم الضيف')),
                    );
                    return;
                  }

                  setState(() => isLoading = true);

                  final result = await context
                      .read<MemberSubscriptionCubit>()
                      .useInvitation(
                        subscription: subscription,
                        guestName: name,
                        guestPhone: phoneController.text.trim(),
                      );

                  setState(() => isLoading = false);

                  result.fold(
                    (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('حدث خطأ: $error')),
                      );
                    },
                    (_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم تسجيل الدعوة بنجاح')),
                      );
                      Navigator.pop(context); // تقفل الـ Dialog
                    },
                  );
                },
          child: const Text('تأكيد'),
        ),
      ],
    );
  }
}
