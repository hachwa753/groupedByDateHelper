import 'package:intl/intl.dart';

extension DateFormatExt on DateTime {
  String get yMMMMd => DateFormat.yMMMMd().format(this);
}

extension StringExtension on String {
  /// Capitalizes the first letter of the string
  String capitalize() {
    if (isEmpty) return '';
    return this[0].toUpperCase() + substring(1);
  }
}

extension DateTimeExt on DateTime {
  String get groupedString {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final date = DateTime(this.year, this.month, this.day);

    if (date == today) return 'Today';
    if (date == yesterday) return 'Yesterday';
    return DateFormat.yMMMEd().format(this);
  }
}
