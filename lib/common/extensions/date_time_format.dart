import 'package:intl/intl.dart';

extension DateTimeFormat on String {
  String formatDateTime() {
    try {
      DateTime parsedDate = DateTime.parse(this);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return '';
    }
  }
}
