import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ConvertService {
  String convertTimeStampToHumanDate(Timestamp timeStamp) {
    var dateToTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat('dd/MM/yyyy').format(dateToTimeStamp);
  }
}
