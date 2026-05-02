import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/stocks_screen.dart';
import 'screens/reports_screen.dart';

void main() {
  runApp(const StockTrackApp());
}

class StockTrackApp extends StatelessWidget {
  const StockTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "StockTrack",
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int currentIndex = 0;

  final screens = const [
    HomeScreen(),
    InventoryScreen(),
    StocksScreen(),
    ReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,

        onDestinationSelected: (value){
          setState(() {
            currentIndex=value;
          });
        },

        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(Icons.inventory),
            label: "Inventory",
          ),

          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: "Stock",
          ),

          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: "Reports",
          ),
        ],
      ),
    );
  }
}