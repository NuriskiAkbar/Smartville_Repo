String dateForHistory(DateTime date) {
  String getDate = date.day < 10 ? "0${date.day}" : "${date.day}";
  String getMonth = getMonthLocal(date.month);
  String getYear = "${date.year}";

  String getHour = date.hour < 10 ? "0${date.hour}" : "${date.hour}";
  String getMinute = date.minute < 10 ? "0${date.minute}" : "${date.minute}";
  return "$getDate $getMonth $getYear, $getHour.$getMinute";
}

String getMonthLocal(int month) {
  switch (month) {
    case 1:
      return "Januari";
    case 2:
      return "Februari";
    case 3:
      return "Maret";
    case 4:
      return "April";
    case 5:
      return "Mei";
    case 6:
      return "Juni";
    case 7:
      return "Juli";
    case 8:
      return "Agustus";
    case 9:
      return "September";
    case 10:
      return "Oktober";
    case 11:
      return "November";
    case 12:
      return "Desember";
    default:
      return "Error month";
  }
}
