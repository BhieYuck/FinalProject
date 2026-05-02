import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            const Text(
              "Inventory",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(30),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(

                children: const [

                  ItemTile("Rice","20 pcs"),
                  ItemTile("Soap","8 pcs"),
                  ItemTile("Noodles","0 pcs"),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {

  final String name;
  final String qty;

  const ItemTile(
      this.name,
      this.qty,
      {super.key});

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        title: Text(name),
        trailing: Text(qty),
      ),
    );
  }
}