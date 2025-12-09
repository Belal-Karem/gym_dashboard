import 'package:intl/intl.dart';

class DateHelper {
  static String convertToIso(String input) {
    try {
      final parts = input.split('-');
      if (parts.length != 3) return input;
      final day = parts[0].padLeft(2, '0');
      final month = parts[1].padLeft(2, '0');
      final year = parts[2];
      return '$year-$month-$day';
    } catch (_) {
      return input;
    }
  }

  // حساب تاريخ الانتهاء
  static String calculateEndDate(String start, String duration) {
    try {
      final startDate = DateTime.parse(convertToIso(start));
      final days = int.tryParse(duration) ?? 0;
      final endDate = startDate.add(Duration(days: days));
      return endDate.toIso8601String();
    } catch (_) {
      return start;
    }
  }

  // حساب عدد الأيام المتبقية من اليوم لتاريخ الانتهاء
  static int calculateDaysRemaining(String end) {
    try {
      final endDate = DateTime.parse(end);
      final now = DateTime.now();
      final remaining = endDate.difference(now).inDays;
      return remaining > 0 ? remaining : 0; // لو خلص الاشتراك رجع 0
    } catch (_) {
      return 0;
    }
  }

  static String formatPaymentDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(date);

      int hour = dateTime.hour;
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final ampm = hour >= 12 ? 'PM' : 'AM';
      hour = hour % 12 == 0 ? 12 : hour % 12;

      return '${dateTime.day.toString().padLeft(2, '0')}/'
          '${dateTime.month.toString().padLeft(2, '0')}/'
          '${dateTime.year} '
          '$hour:$minute $ampm';
    } catch (e) {
      return '';
    }
  }
}
