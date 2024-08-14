extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension HourOnlyCompare on DateTime {
  bool isSameHour(DateTime other) {
    return hour == other.hour;
  }
}
