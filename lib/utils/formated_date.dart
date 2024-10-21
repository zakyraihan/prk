import 'package:intl/intl.dart';

String formattedDate(DateTime? date) {
  if (date == null) return "Unknown Date"; // Handle null cases
  return DateFormat('dd MMMM yyyy, HH:mm').format(date);
}
