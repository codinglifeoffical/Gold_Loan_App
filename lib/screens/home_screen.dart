import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/gold_price_card.dart';
import '../widgets/plan_card.dart';
import '../widgets/custom_button.dart';
import '../utils/constants.dart';
import '../widgets/main_layout.dart';
import 'package:provider/provider.dart';
import '../providers/gold_provider.dart';
import '../widgets/quick_save_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0,
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<GoldProvider>().fetchPrice();
          },
          color: AppColors.primary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: const Icon(
                            Icons.diamond_outlined,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Hey!",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "User Name",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 16,
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                // Gold Price Card
                const GoldPriceCard(),

                const SizedBox(height: 24),
                // Main Actions
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "Start Savings",
                        onPressed: () {
                          Navigator.pushNamed(context, '/savings');
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: "Sell",
                        isPrimary: false,
                        onPressed: () {
                          Navigator.pushNamed(context, '/sell');
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Auto Savings Plan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Auto Savings Plan",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      PlanCard(
                        title: "Daily",
                        subtitle: "Automate daily",
                        price: "₹30",
                        isBestValue: true,
                      ),
                      SizedBox(width: 12),
                      PlanCard(
                        title: "Weekly",
                        subtitle: "Automate weekly",
                        price: "₹100",
                      ),
                      SizedBox(width: 12),
                      PlanCard(
                        title: "Monthly",
                        subtitle: "Automate monthly",
                        price: "₹500",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Quick Gold Save
                Text(
                  "Quick Gold Save",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const QuickSaveCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
