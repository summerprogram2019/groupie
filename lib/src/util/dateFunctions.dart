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
        month = "January";
        break;
      case 2:
        month = "February";
        break;
      case 3:
        month = "March";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "August";
        break;
      case 9:
        month = "September";
        break;
      case 10:
        month = "October";
        break;
      case 11:
        month = "November";
        break;
      case 12:
        month = "December";
        break;
    }
    return month;
  }
}
