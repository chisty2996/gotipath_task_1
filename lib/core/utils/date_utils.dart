import 'package:intl/intl.dart';

class DateTimeUtilities {
  static String formatDateTime(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr).toLocal();

    String formattedDate = DateFormat('MMMM d, y').format(dateTime);

    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    return "$formattedDate at $formattedTime";
  }
}