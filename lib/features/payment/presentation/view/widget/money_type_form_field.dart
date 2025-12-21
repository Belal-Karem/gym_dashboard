import 'package:flutter/material.dart';

enum MoneyType { income, expense }

class MoneyTypeFormField extends FormField<MoneyType> {
  MoneyTypeFormField({
    super.key,
    FormFieldSetter<MoneyType>? onSaved,
    FormFieldValidator<MoneyType>? validator,
    MoneyType? initialValue,
    required ValueChanged<MoneyType> onChanged,
  }) : super(
         initialValue: initialValue,
         validator: validator,
         onSaved: onSaved,
         builder: (state) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 children: [
                   Checkbox(
                     value: state.value == MoneyType.income,
                     onChanged: (_) {
                       state.didChange(MoneyType.income);
                       onChanged(MoneyType.income);
                     },
                   ),
                   const Text('إدخال'),

                   const SizedBox(width: 20),

                   Checkbox(
                     value: state.value == MoneyType.expense,
                     onChanged: (_) {
                       state.didChange(MoneyType.expense);
                       onChanged(MoneyType.expense);
                     },
                   ),
                   const Text('إخراج'),
                 ],
               ),

               /// رسالة الخطأ
               if (state.hasError)
                 Padding(
                   padding: const EdgeInsets.only(left: 8, top: 4),
                   child: Text(
                     state.errorText!,
                     style: const TextStyle(color: Colors.red, fontSize: 12),
                   ),
                 ),
             ],
           );
         },
       );
}
