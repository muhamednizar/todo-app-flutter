// import 'package:intl/intl.dart';
//
// String dateFormated(DateTime date){
// final DateFormat formatter = DateFormat('dd / MM / yyyy');
// return  formatter.format(date);
//
// }
import 'package:intl/intl.dart';

extension FormatDate on DateTime {
  String get dateFormatted => '$day / $month / $year';

  String get getDay {
    DateFormat formatter = DateFormat('E');
    return formatter.format(this);
  }
}
