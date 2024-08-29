import 'package:intl/intl.dart';

class DateFormater {
  static String changeDateEdited(DateTime dateTime) {
    DateTime nowDateTime = DateTime.now();
    if (dateTime.day == nowDateTime.day) {
      return "Edited ${DateFormat().add_Hm().format(dateTime)}";
    } else if (dateTime.year == nowDateTime.year) {
      return "Edited ${DateFormat('d MMM').format(dateTime)}";
    } else if (dateTime.year < nowDateTime.year) {
      return "Edited ${DateFormat('d MMM yyyy').format(dateTime)}";
    }
    return "";
  }
}
