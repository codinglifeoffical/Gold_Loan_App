enum TransactionType { buy, sell }

class Transaction {
  final String id;
  final TransactionType type;
  final double weight;
  final double amount;
  final double pricePerGram;
  final DateTime date;

  Transaction({
    required this.id,
    required this.type,
    required this.weight,
    required this.amount,
    required this.pricePerGram,
    required this.date,
  });
}
