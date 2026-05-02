import 'package:flutter/material.dart';

class BottomNav
    extends StatelessWidget {

  final int currentIndex;

  final Function(int)
  onTap;

  const BottomNav({

    super.key,

    required this.currentIndex,

    required this.onTap,

  });

  @override
  Widget build(
      BuildContext context) {

    return NavigationBar(

      height: 75,

      selectedIndex:
      currentIndex,

      onDestinationSelected:
      onTap,

      destinations:
      const [

        NavigationDestination(
          icon:
          Icon(Icons.home),
          label: "Home",
        ),

        NavigationDestination(
          icon:
          Icon(Icons.inventory),
          label:
          "Inventory",
        ),

        NavigationDestination(
          icon:
          Icon(Icons.shopping_cart),
          label:
          "Stock",
        ),

        NavigationDestination(
          icon:
          Icon(Icons.bar_chart),
          label:
          "Reports",
        ),

      ],
    );
  }
}