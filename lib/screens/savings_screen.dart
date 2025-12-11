import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/plan_card.dart';
import '../utils/constants.dart';

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Savings Plans",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSectionHeader("Popular Plans"),
            const SizedBox(height: 16),
            const Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                PlanCard(
                  title: "Daily",
                  subtitle: "Save daily small amounts",
                  price: "₹30",
                  isBestValue: true,
                ),
                PlanCard(
                  title: "Weekly",
                  subtitle: "Save weekly for consistency",
                  price: "₹100",
                ),
                PlanCard(
                  title: "Monthly",
                  subtitle: "Big savings every month",
                  price: "₹500",
                ),
                PlanCard(
                  title: "Custom",
                  subtitle: "Flexible savings",
                  price: "Any",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(width: 4, height: 20, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
