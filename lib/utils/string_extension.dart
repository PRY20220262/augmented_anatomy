import 'dart:core';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';

extension StringExtension on String {
  String toFormattedDateString() {
    final dateTime = DateTime.parse(this);
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();
    return '$day/$month/$year';
  }
}

String substractSixHoursFromDateTime(String dateTimeString) {
  final dateTime = DateTime.parse(dateTimeString).subtract(Duration(hours: 5));
  final timeString = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  return 'Hora: $timeString';
}

String getDisplayText(String? url) {
  if (url == null || url.isEmpty) {
    return '';
  }

  if (url.length <= 20) {
    return url;
  } else {
    return '${url.substring(0, 30)}...';
  }
}