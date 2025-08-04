extension DateExtensions on DateTime {
  int daysFrom(DateTime to) {
    final from = DateTime(year, month, day);
    final nto = DateTime(to.year, to.month, to.day);
    return (nto.difference(from).inHours / 24).round();
  }

  bool get isToday {
    final today = DateTime.now();

    return year == today.year && month == today.month && day == today.day;
  }

  bool get isJummahToday {
    return weekday == 5;
  }

}