class DateFunctions {

  static String addZero(int number){
    return number < 10 ? "0" + number.toString() : number.toString();
  }

  static String getDateString(DateTime date) {
    return date.day.toString() +
        " " +
        DateFunctions.getMonthName(date) +
        " " +
        addZero(date.hour) +
        ":" +
        addZero(date.minute);
  }

  static String getMonthName(DateTime tm) {
    String month;
    switch (tm.month) {
      case 1:
        month = "january";
        break;
      case 2:
        month = "february";
        break;
      case 3:
        month = "march";
        break;
      case 4:
        month = "april";
        break;
      case 5:
        month = "may";
        break;
      case 6:
        month = "june";
        break;
      case 7:
        month = "july";
        break;
      case 8:
        month = "august";
        break;
      case 9:
        month = "september";
        break;
      case 10:
        month = "october";
        break;
      case 11:
        month = "november";
        break;
      case 12:
        month = "december";
        break;
    }
    return month;
  }
}
