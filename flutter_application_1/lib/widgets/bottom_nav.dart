import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int index;
  final Function(int) onTap;

  const BottomNav({
    super.key,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onTap,

      type: BottomNavigationBarType.fixed,

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory),
          label: "Inventory",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_vert),
          label: "Stock",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: "Reports",
        ),
      ],
    );
  }
}