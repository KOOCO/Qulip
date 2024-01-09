import 'package:intl/intl.dart';

class DateTimeHelper {
  static String defaultpattern = 'dd-MM-y hh:mm a';
  static const String dateOnly = 'dd-MM-y';
  static const String caseDateFormate = 'yyyyMMddhhmmss';
  static const String date2Only = 'dd/MM/yyyy';
  static const String timeOnly = 'hh:mm a';
  static const String time24Only = 'H:m:s';
  static const String serverDob = 'yyyy-MM-dd';
  static const String mobileDob = 'dd/MM/y';
  static const String monthName = 'd MMM';
  static const String dayName = 'EEE';
  static const String monthYear = 'MMM yyyy';
}

String daysAgo(String time) {
  final notificationtime = DateTime.parse(
    time,
  ).toLocal();
  final diff = DateTime.now().toUtc().difference(notificationtime).inDays;

  if (diff >= 365) {
    final years = diff ~/ 365;
    return years > 1 ? '$years years ago' : 'A year Ago';
  } else if (diff >= 30) {
    final months = diff ~/ 30;
    return months > 1 ? '$months months ago' : 'A month Ago';
  } else if (diff >= 1) {
    return '$diff days ago';
  } else {
    final minutes = DateTime.now().difference(notificationtime).inMinutes;
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      return hours > 1 ? '$hours hours ago' : 'An hour ago';
    } else {
      return minutes > 1 ? '$minutes minutes ago' : 'A minute ago';
    }
  }
}

String daysAgoShorInfo(String time) {
  final notificationtime = DateTime.parse(
    time,
  ).toLocal();
  final diff = DateTime.now().toUtc().difference(notificationtime).inDays;

  if (diff >= 365) {
    final years = diff ~/ 365;
    return years > 1 ? '$years years' : '$years year';
  } else if (diff >= 30) {
    final months = diff ~/ 30;
    return months > 1 ? '$months months' : '$months month';
  } else if (diff >= 1) {
    return diff > 1 ? '$diff days' : '$diff day';
  } else {
    final minutes = DateTime.now().difference(notificationtime).inMinutes;
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      return '${hours}hr';
    } else {
      return '${minutes}min';
    }
  }
}

extension Format on DateTime {
  String defaultFormat() {
    return DateFormat(DateTimeHelper.defaultpattern).format(this);
  }

  String dateOnly() {
    String formatstr = DateTimeHelper.defaultpattern;
    formatstr = formatstr
        .replaceAll('h', '')
        .replaceAll('m', '')
        .replaceAll('A', '')
        .replaceAll('a', '')
        .replaceAll('H', '')
        .replaceAll(':', '')
        .trim();
    return DateFormat(formatstr).format(this);
  }

  String caseGeneratorDateFormate() =>
      DateFormat(DateTimeHelper.caseDateFormate).format(this);
  String date2Only() => DateFormat(DateTimeHelper.date2Only).format(this);
  String timeOnly() => DateFormat(DateTimeHelper.timeOnly).format(this);
  String time24Only() => DateFormat(DateTimeHelper.time24Only).format(this);
  String serverDOB() => DateFormat(DateTimeHelper.serverDob).format(this);
  String mobileDOB() => DateFormat(DateTimeHelper.mobileDob).format(this);
  String monthName() => DateFormat(DateTimeHelper.monthName).format(this);
  String dayName() => DateFormat(DateTimeHelper.dayName).format(this);
  String monthYear() => DateFormat(DateTimeHelper.monthYear).format(this);

  String format(String format) {
    try {
      return DateFormat(format).format(this);
    } catch (e) {
      return toString();
    }
  }
}
