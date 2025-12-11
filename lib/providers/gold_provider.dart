import 'dart:async';
import 'package:flutter/material.dart';
import '../models/gold_price_model.dart';
import '../services/api_service.dart';

class GoldProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  GoldPrice _currentPrice = GoldPrice.empty();
  bool _isLoading = true;
  String? _error;

  GoldPrice get currentPrice => _currentPrice;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Timer? _timer;

  GoldProvider() {
    fetchPrice();
    _startLiveUpdates();
  }

  void _startLiveUpdates() {
    _timer = Timer.periodic(const Duration(hours: 1), (timer) {
      fetchPrice();
    });
  }

  Future<void> fetchPrice() async {
    try {
      final price = await _apiService.fetchGoldPrice();
      _currentPrice = price;
      _isLoading = false;
      _error = null;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to fetch live price';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
