import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import 'package:uuid/uuid.dart';

class PortfolioProvider with ChangeNotifier {
  double _currentGoldBalance = 2.50; // Initial mocked balance
  final List<Transaction> _transactions = [];

  double get currentGoldBalance => _currentGoldBalance;
  List<Transaction> get transactions => List.unmodifiable(_transactions);

  // For checking if user has enough balance
  bool hasSufficientBalance(double weight) {
    return _currentGoldBalance >= weight;
  }

  Future<bool> sellGold(double weight, double pricePerGram) async {
    if (!hasSufficientBalance(weight)) {
      return false;
    }

    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      _currentGoldBalance -= weight;

      final amount = weight * pricePerGram;

      final transaction = Transaction(
        id: const Uuid().v4(),
        type: TransactionType.sell,
        weight: weight,
        amount: amount,
        pricePerGram: pricePerGram,
        date: DateTime.now(),
      );

      _transactions.insert(0, transaction); // Add to top
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Method to simulate adding gold (for testing purposes or future buy feature)
  void addGold(double weight, double pricePerGram) {
    _currentGoldBalance += weight;

    final amount = weight * pricePerGram;

    final transaction = Transaction(
      id: const Uuid().v4(),
      type: TransactionType.buy,
      weight: weight,
      amount: amount,
      pricePerGram: pricePerGram,
      date: DateTime.now(),
    );

    _transactions.insert(0, transaction);
    notifyListeners();
  }
}
