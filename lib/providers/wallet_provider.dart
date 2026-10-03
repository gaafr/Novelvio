import 'package:flutter/foundation.dart';

class WalletProvider extends ChangeNotifier {
  int _points = 0;
  bool _isLoading = false;

  int get points => _points;
  bool get isLoading => _isLoading;

  void addPoints(int amount) {
    if (amount > 0) {
      _points += amount;
      notifyListeners();
    }
  }

  void removePoints(int amount) {
    if (amount > 0 && _points >= amount) {
      _points -= amount;
      notifyListeners();
    }
  }

  void setPoints(int amount) {
    if (amount >= 0) {
      _points = amount;
      notifyListeners();
    }
  }

  Future<void> requestWithdrawal(int points, String method) async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Implement actual Supabase withdrawal request
      // This should call a Supabase function or insert into withdrawals table
      // Only the server/database should process the actual payout
      await Future.delayed(const Duration(seconds: 1));
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
