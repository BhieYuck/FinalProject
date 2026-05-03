import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/stocks_screen.dart';
import 'screens/reports_screen.dart';

void main() {
  runApp(
    const StockTrackApp(),
  );
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

      title: "StockTrack",

      theme: ThemeData(

        useMaterial3: true,

        scaffoldBackgroundColor:
        const Color(0xffF8FAFC),

        fontFamily: "Arial",
      ),

      home:
      const MainNavigation(),
    );
  }
}

class MainNavigation
    extends StatefulWidget {

  const MainNavigation({
    super.key,
  });

  @override
  State<MainNavigation>
  createState() =>
      _MainNavigationState();
}

class _MainNavigationState
    extends State<
        MainNavigation> {

  int currentIndex = 0;

  final List<Widget>
  screens = const [

    HomeScreen(),

    InventoryScreen(),

    StockScreen(),

    ReportsScreen(),

  ];

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      body:
      SafeArea(

        child:
        screens[
        currentIndex],
      ),

      bottomNavigationBar:
      Container(

        decoration:
        BoxDecoration(

          color:
          Colors.white,

          boxShadow: [

            BoxShadow(

              color:
              Colors.grey
                  .withOpacity(.12),

              blurRadius: 10,

            ),

          ],
        ),

        child:
        BottomNavigationBar(

          currentIndex:
          currentIndex,

          onTap:
              (index){

            setState(() {

              currentIndex =
                  index;

            });

          },

          type:
          BottomNavigationBarType
              .fixed,

          backgroundColor:
          Colors.white,

          selectedItemColor:
          const Color(
              0xff2563EB),

          unselectedItemColor:
          Colors.grey,

          selectedFontSize:
          12,

          unselectedFontSize:
          12,

          items: const [

            BottomNavigationBarItem(

              icon:
              Icon(
                  Icons.home),

              label:
              "Home",
            ),

            BottomNavigationBarItem(

              icon:
              Icon(
                  Icons.inventory_2),

              label:
              "Inventory",
            ),

            BottomNavigationBarItem(

              icon:
              Icon(
                  Icons.swap_horiz),

              label:
              "Stock",
            ),

            BottomNavigationBarItem(

              icon:
              Icon(
                  Icons.bar_chart),

              label:
              "Reports",
            ),

          ],
        ),
      ),
    );
  }
}