import 'package:flutter/material.dart';

import 'models/item_model.dart';

import 'screens/home_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/stocks_screen.dart';
import 'screens/reports_screen.dart';

import 'widgets/bottom_nav.dart';

void main() {
  runApp(const StockTrackApp());
}

class StockTrackApp extends StatelessWidget {
  const StockTrackApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MobileFrame(),
    );
  }
}

class MobileFrame extends StatefulWidget {
  const MobileFrame({super.key});

  @override
  State<MobileFrame> createState() =>
      _MobileFrameState();
}

class _MobileFrameState
    extends State<MobileFrame> {

  int currentIndex = 0;

  final List<ItemModel> items = [

    ItemModel(
      name: "Rice",
      quantity: 20,
      category: "Food",
      usedCount: 18,
      expiryDate:
      DateTime.now().add(
        const Duration(days: 90),
      ),
    ),

    ItemModel(
      name: "Soap",
      quantity: 2,
      category: "Supplies",
      usedCount: 30,
      expiryDate:
      DateTime.now().add(
        const Duration(days: 14),
      ),
    ),

    ItemModel(
      name: "Noodles",
      quantity: 4,
      category: "Food",
      usedCount: 12,
      expiryDate:
      DateTime.now().add(
        const Duration(days: 20),
      ),
    ),

  ];

  void addItem(
      String name,
      int qty,
      String category,
      ) {

    setState(() {

      items.add(

        ItemModel(

          name: name,
          quantity: qty,
          category: category,

          usedCount: 0,

          expiryDate:
          DateTime.now().add(
            const Duration(
                days: 90),
          ),
        ),
      );

    });
  }

  void restockItem(
      ItemModel item) {

    setState(() {
      item.quantity += 10;
    });
  }

  @override
  Widget build(
      BuildContext context) {

    final screens = [

      HomeScreen(
        items: items,
        onAdd: addItem,
      ),

      InventoryScreen(
        items: items,
        onAdd: addItem,
      ),

      StocksScreen(
        items: items,
        onRestock:
        restockItem,
      ),

      ReportsScreen(
        items: items,
      ),

    ];

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
            Colors.white,

            borderRadius:
            BorderRadius.circular(
                30),

            boxShadow: [

              BoxShadow(

                blurRadius: 20,

                color: Colors.black
                    .withOpacity(.15),
              )

            ],
          ),

          clipBehavior:
          Clip.antiAlias,

          child: Scaffold(

            body:
            screens[
            currentIndex],

            bottomNavigationBar:
            BottomNav(

              currentIndex:
              currentIndex,

              onTap:
                  (value){

                setState(() {

                  currentIndex =
                      value;

                });

              },
            ),
          ),
        ),
      ),
    );
  }
}