// import 'package:intl/intl.dart';
//
// String dateFormated(DateTime date){
// final DateFormat formatter = DateFormat('dd / MM / yyyy');
// return  formatter.format(date);
//
// }
extension FormatDate on DateTime {
  String get dateFormatted => '$day / $month / $year';

  String get getDay {
    List<String> weekDays = ['SAT', 'SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI'];
    return weekDays[weekday - 1];
  }
}
