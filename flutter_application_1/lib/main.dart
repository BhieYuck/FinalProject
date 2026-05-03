import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/stock_screen.dart';
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

      theme: ThemeData(
        useMaterial3: true,
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

  final screens = const [

    HomeScreen(),

    InventoryScreen(),

    StockScreen(),

    ReportsScreen(),

  ];

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      backgroundColor:
      Colors.grey.shade300,

      body: Center(

        child: Container(

          width: 390,
          height: 844,

          decoration:
          BoxDecoration(

            color:
            const Color(
                0xffF8FAFC),

            borderRadius:
            BorderRadius.circular(
                35),

            boxShadow: [

              BoxShadow(

                color:
                Colors.black
                    .withOpacity(.15),

                blurRadius:
                20,

              ),

            ],
          ),

          clipBehavior:
          Clip.antiAlias,

          child: Scaffold(

            body:
            SafeArea(

              child:
              screens[
              currentIndex],
            ),

            bottomNavigationBar:
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

              selectedItemColor:
              const Color(
                  0xff2563EB),

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
        ),
      ),
    );
  }
}
