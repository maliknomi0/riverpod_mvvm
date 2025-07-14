import 'package:intl/intl.dart';

String formatPrice(dynamic price) {
  final formatter = NumberFormat("#,##0.00", "en_US");

  if (price == null) return 'N/A';

  double parsedPrice;
  if (price is String) {
    parsedPrice = double.tryParse(price) ?? 0.0;
  } else if (price is num) {
    parsedPrice = price.toDouble();
  } else {
    return 'N/A';
  }

  return formatter.format(parsedPrice);
}

String trimToTwoWords(String text) {
  final words = text.trim().split(RegExp(r'\s+')); // splits on any space
  if (words.length <= 2) return text;
  return "${words[0]} ${words[1]}";
}

// Function to format strings: replace underscores with spaces and capitalize each word
String formatString(String input) {
  return input
      .replaceAll('_', ' ')
      .split(' ')
      .map(
        (word) =>
            word.isNotEmpty
                ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                : '',
      )
      .join(' ');
}
