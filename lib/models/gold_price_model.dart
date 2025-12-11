class GoldPrice {
  final double pricePerGram;
  final double changePercentage;
  final bool isUp;
  final DateTime timestamp;

  GoldPrice({
    required this.pricePerGram,
    required this.changePercentage,
    required this.isUp,
    required this.timestamp,
  });

  factory GoldPrice.empty() {
    return GoldPrice(
      pricePerGram: 0.0,
      changePercentage: 0.0,
      isUp: true,
      timestamp: DateTime.now(),
    );
  }
}
