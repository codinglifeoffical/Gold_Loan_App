import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/gold_provider.dart';
import '../widgets/main_layout.dart';
import '../utils/constants.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _gramsController = TextEditingController();
  double _loanAmount = 0.0;

  void _calculateLoan() {
    final goldPrice = Provider.of<GoldProvider>(
      context,
      listen: false,
    ).currentPrice.pricePerGram;
    final grams = double.tryParse(_gramsController.text) ?? 0.0;

    // Logic: Loan Amount = (Gold Price * Grams) * 0.75 (75% LTV usually for Gold Loans)
    setState(() {
      _loanAmount = (goldPrice * grams) * 0.75;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex:
          1, // "Invest/Coins" tab roughly mapped here or we can use another index
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Gold Loan Calculator",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Check how much loan you can get against your gold.",
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
              const SizedBox(height: 32),

              Text(
                "Enter Gold Weight (gms)",
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _gramsController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (_) => _calculateLoan(),
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

              const SizedBox(height: 40),

              Center(
                child: Column(
                  children: [
                    Text(
                      "Eligible Loan Amount",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "₹ ${_loanAmount.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "(Approx 75% of market value)",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
