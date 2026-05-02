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
      home: const MobileFrame(),
    );
  }
}

class MobileFrame extends StatefulWidget {
  const MobileFrame({super.key});

  @override
  State<MobileFrame> createState() => _MobileFrameState();
}

class _MobileFrameState extends State<MobileFrame> {

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
      backgroundColor: Colors.grey.shade300,

      body: Center(
        child: Container(
          width: 390,
          height: 844,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.15),
              ),
            ],
          ),

          clipBehavior: Clip.antiAlias,

          child: Scaffold(

            body: screens[currentIndex],

            bottomNavigationBar: NavigationBar(

              height: 75,
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
          ),
        ),
      ),
    );
  }
}