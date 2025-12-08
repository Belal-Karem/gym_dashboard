String? phoneValidator(String? value) {
  if (value == null || value.trim().isEmpty) return 'مطلوب';
  if (value.trim().length != 11) return 'رقم الموبايل يجب أن يكون 11 رقمًا';
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) return 'رقم الموبايل أرقام فقط';
  return null;
}
