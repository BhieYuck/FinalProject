import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final items = [
      "Rice",
      "Soap",
      "Noodles",
    ];

    return Scaffold(

      appBar: AppBar(
        title: const Text("Inventory"),
      ),

      body: ListView.builder(

        itemCount: items.length,

        itemBuilder: (_, index){

          return ListTile(
            title: Text(items[index]),
            trailing: const Text("20 pcs"),
          );

        },
      ),
    );
  }
}