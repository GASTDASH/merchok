extension DateTimeExtension on DateTime {
  String toRusDate() =>
      "$day ${switch (month) {
        1 => "января",
        2 => "февраля",
        3 => "марта",
        4 => "апреля",
        5 => "мая",
        6 => "июня",
        7 => "июля",
        8 => "августа",
        9 => "сентября",
        10 => "октября",
        11 => "ноября",
        12 => "декабря",
        int() => "{month}",
      }} $year";

  String toCompactString() =>
      toIso8601String().split('T')[0].split('-').reversed.join('.');
}

extension DoubleExtension on double {
  String truncateIfInt() => this % 1 == 0 ? "${truncate()}" : "$this";
}
