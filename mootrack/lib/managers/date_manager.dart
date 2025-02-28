class DateManager {
  static String getFormattedDate(DateTime date) {
    return "${date.day}.${date.month}.${date.year}";
  }

  static String getFormattedTime(DateTime date) {
    return "${date.hour}:${date.minute}";
  }

  ///Get the formatted date and time
  ///Example: 12.12.2022 12:12
  ///@param date The date to format
  ///@return The formatted date and time
  static String getFormattedDateAndTime(DateTime datetime) {
    return "${getFormattedDate(datetime)} ${getFormattedTime(datetime)}";
  }
}
