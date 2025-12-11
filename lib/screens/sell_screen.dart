import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_button.dart';
import '../utils/constants.dart';
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../providers/gold_provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final TextEditingController _gramsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sell Gold",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Available Balance",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${context.watch<PortfolioProvider>().currentGoldBalance.toStringAsFixed(2)} gms",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.account_balance_wallet,
                    color: AppColors.primary,
                    size: 30,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            Text(
              "Enter Weight to Sell (gms)",
              style: GoogleFonts.poppins(fontSize: 16),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _gramsController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.cardColor,
                suffixText: "gms",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const Spacer(),
            CustomButton(
              text: "Preview Sell Order",
              onPressed: () async {
                final weightText = _gramsController.text;
                if (weightText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter weight")),
                  );
                  return;
                }

                final weight = double.tryParse(weightText);
                if (weight == null || weight <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Invalid weight")),
                  );
                  return;
                }

                final portfolio = context.read<PortfolioProvider>();
                if (!portfolio.hasSufficientBalance(weight)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Insufficient gold balance")),
                  );
                  return;
                }

                final goldProvider = context.read<GoldProvider>();
                final price = goldProvider.currentPrice.pricePerGram;

                // Confirm Dialog
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Confirm Sell"),
                    content: Text(
                      "Sell $weight gms for ₹${(weight * price).toStringAsFixed(2)}?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Confirm"),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  final success = await portfolio.sellGold(weight, price);
                  if (success && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Gold sold successfully!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    _gramsController.clear();
                  }
                }
              },
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
