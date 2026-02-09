class DateHelper {
  static DateTime parseDate(String input) {
    try {
      if (input.contains('-')) {
        final parts = input.split('-');

        // dd-MM-yyyy
        if (parts[0].length == 2) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          return DateTime(year, month, day);
        }

        // yyyy-MM-dd
        return DateTime.parse(input);
      }

      return DateTime.parse(input);
    } catch (_) {
      throw FormatException('Invalid date format');
    }
  }

  static DateTime calculateEndDate({
    required DateTime startDate,
    required int durationDays,
  }) {
    return startDate.add(Duration(days: durationDays));
  }

  static int calculateRemainingDays(DateTime endDate) {
    final today = DateTime.now();
    final remaining = endDate.difference(today).inDays;
    return remaining < 0 ? 0 : remaining;
  }

  static String formatPaymentDate(DateTime date) {
    int hour = date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final ampm = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12 == 0 ? 12 : hour % 12;

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '$hour:$minute $ampm';
  }
}
