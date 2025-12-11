import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final int currentIndex;
  const MainLayout({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  void _onItemTapped(int index) {
    if (index == widget.currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        // Placeholder for Coins/Invest
        Navigator.pushReplacementNamed(context, '/invest');
        break;
      case 2:
        Navigator.pushReplacementNamed(
          context,
          '/calculator',
        ); // Using Invest/Calc for center
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/transactions');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/portfolio');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: AppColors.background),
        child: BottomNavigationBar(
          currentIndex: widget.currentIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined),
              label: "Coins",
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundColor:
                    Colors.transparent, // Highlight logic can be custom
                radius: 14,
                child: Icon(Icons.show_chart),
              ),
              label: "Invest",
              activeIcon: CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 14,
                child: Icon(Icons.show_chart, color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows),
              label: "Transactions",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outline),
              label: "Portfolio",
            ),
          ],
        ),
      ),
    );
  }
}
