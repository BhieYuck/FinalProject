import 'package:flutter/material.dart';

class StocksScreen extends StatelessWidget {
  const StocksScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            const Text(
              "Stocks",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const ListTile(
              title: Text("Soap"),
              subtitle: Text("2 pcs left"),
              trailing: Icon(
                Icons.warning,
                color: Colors.orange,
              ),
            ),

            const ListTile(
              title: Text("Coffee"),
              subtitle: Text("2 pcs left"),
              trailing: Icon(
                Icons.warning,
                color: Colors.orange,
              ),
            ),

            const Divider(),

            const ListTile(
              title: Text("Milk"),
              subtitle: Text("Expires in 2 days"),
              trailing: Icon(
                Icons.remove_circle,
                color: Colors.red,
              ),
            ),

          ],
        ),
      ),
    );
  }
}