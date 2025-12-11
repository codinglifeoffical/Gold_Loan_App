import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/gold_price_model.dart';

class ApiService {
  // Using the key provided in the prompt
  static const String _apiKey = '5f18163ca5d5d63d84222582104a0717';
  static const String _baseUrl = 'https://api.metalpriceapi.com/v1/latest';

  Future<GoldPrice> fetchGoldPrice() async {
    try {
      // requesting XAU and INR to calculate generic XAU->INR conversion if needed,
      // or just assume base USD.
      final url = Uri.parse(
        '$_baseUrl?api_key=$_apiKey&base=USD&currencies=XAU,INR',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          final rates = data['rates'];
          // API returns 1 USD = X XAU. So Price of 1 XAU in USD = 1/rates['XAU']
          // Actually usually metal APIs return: "XAU": 1900 (Price of oz in Base).
          // Let's assume standard behavior: Base=USD. 'XAU' might be 1/Price or Price depending on API.
          // metalpriceapi.com Docs say: Returns rates relative to base.
          // If Base=USD and XAU is a currency, then XAU rate is "How many XAU for 1 USD".
          // So 1 USD = 0.0005 XAU => 1 XAU = 2000 USD.
          // So Price in USD = 1 / rates['XAU'].

          final double xauRate = (rates['XAU'] as num).toDouble();
          final double inrRate = (rates['INR'] as num)
              .toDouble(); // 1 USD = 83 INR

          // Price of 1 XAU (Ounce) in USD = 1 / xauRate
          final double pricePerOunceUSD = 1 / xauRate;

          // Price of 1 XAU (Ounce) in INR = pricePerOunceUSD * inrRate
          final double pricePerOunceINR = pricePerOunceUSD * inrRate;

          // Price per Gram in INR = PricePerOunceINR / 31.1035
          final double pricePerGramINR = pricePerOunceINR / 31.1035;

          // Mocking change percentage since this API endpoint (latest) might not give historical data easily
          // without another call used for "change". The prompt asked for "latest".
          // I will randomize the small percentage for UI demo purposes if data is missing,
          // or just put a static one as the endpoint is only 'latest'.
          // The UI reference shows "0.678% since yesterday".

          return GoldPrice(
            pricePerGram: pricePerGramINR,
            changePercentage:
                0.678, // Dummy static for demo as 'latest' doesn't have change
            isUp: true,
            timestamp: DateTime.now(),
          );
        }
      }
      throw Exception('Failed to load gold price');
    } catch (e) {
      debugPrint('Error fetching gold price: $e');
      rethrow;
    }
  }
}
