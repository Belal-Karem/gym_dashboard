class DateHelper {
  static String convertToIso(String input) {
    final parts = input.split('-'); // ['12','7','2025']
    if (parts.length != 3) return input; // رجع زي ما هو لو الخطأ
    final day = parts[0].padLeft(2, '0'); // 12
    final month = parts[1].padLeft(2, '0'); // 07
    final year = parts[2]; // 2025
    return '$year-$month-$day'; // 2025-07-12
  }

  static String calculateEndDate(String start, String duration) {
    final startDate = DateTime.parse(convertToIso(start));
    final days = int.parse(duration);
    final endDate = startDate.add(Duration(days: days));
    return endDate.toIso8601String();
  }
}
