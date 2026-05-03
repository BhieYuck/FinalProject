import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/stocks_screen.dart';
import 'screens/reports_screen.dart';

import 'widgets/bottom_nav.dart';

void main() {
  runApp(const StockTrackApp());
}

class StockTrackApp extends StatelessWidget {

  const StockTrackApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner:
      false,

      theme: ThemeData(

        scaffoldBackgroundColor:
        const Color(0xffF5F7FB),

        useMaterial3:
        true,
      ),

      home:
      const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {

  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() =>
      _MainScreenState();
}

class _MainScreenState
    extends State<MainScreen> {

  int currentIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {

    super.initState();

    screens = const [

      HomeScreen(),

      InventoryScreen(),

      StockScreen(),

      ReportsScreen(),

    ];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:
      SafeArea(

        child:
        screens[currentIndex],
      ),

      bottomNavigationBar:
      BottomNav(

        index:
        currentIndex,

        onTap:
            (value){

          setState(() {

            currentIndex =
                value;

          });
        },
      ),
    );
  }
}