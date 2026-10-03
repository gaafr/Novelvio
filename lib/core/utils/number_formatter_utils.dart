class NumberFormatterUtils {
  static String formatMoney(int points) => '\$${(points / 1000).toStringAsFixed(2)}';
}
