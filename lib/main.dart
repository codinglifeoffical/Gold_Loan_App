import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'providers/gold_provider.dart';
import 'providers/portfolio_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/savings_screen.dart';
import 'screens/sell_screen.dart';
import 'screens/calculator_screen.dart';
import 'screens/transactions_screen.dart';
import 'screens/portfolio_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoldProvider()),
        ChangeNotifierProvider(create: (_) => PortfolioProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gold Loan App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/savings': (context) => const SavingsScreen(),
        '/sell': (context) => const SellScreen(),
        '/calculator': (context) =>
            const CalculatorScreen(), // Also acting as "Invest" tab for now
        '/invest': (context) => const CalculatorScreen(), // Alias for nav
        '/transactions': (context) => const TransactionsScreen(),
        '/portfolio': (context) => const PortfolioScreen(),
      },
    );
  }
}
