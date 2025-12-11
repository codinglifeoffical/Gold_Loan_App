import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/main_layout.dart';
import '../utils/constants.dart';
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Transactions",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Consumer<PortfolioProvider>(
          builder: (context, provider, child) {
            final transactions = provider.transactions;

            if (transactions.isEmpty) {
              return Center(
                child: Text(
                  "No transactions yet",
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              itemCount: transactions.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final isBuy = transaction.type == TransactionType.buy;
                final dateStr = DateFormat(
                  'dd MMM yyyy, hh:mm a',
                ).format(transaction.date);

                return Card(
                  color: AppColors.cardColor,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isBuy
                          ? Colors.green.withOpacity(0.2)
                          : Colors.red.withOpacity(0.2),
                      child: Icon(
                        isBuy ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isBuy ? Colors.green : Colors.red,
                      ),
                    ),
                    title: Text(
                      isBuy ? "Gold Purchased" : "Gold Sold",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      dateStr,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${isBuy ? '+' : '-'}${transaction.weight}g",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: isBuy ? Colors.green : Colors.red,
                          ),
                        ),
                        Text(
                          "₹${transaction.amount.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
