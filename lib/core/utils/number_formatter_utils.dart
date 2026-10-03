class NumberFormatterUtils {
  static String formatMoney(int points) {
    final usd = points / 1000.0;
    return '\$${usd.toStringAsFixed(2)}';
  }

  static String formatPoints(int points) {
    return '$points pts';
  }
}
