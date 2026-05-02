import 'package:flutter/material.dart';

class StocksScreen extends StatelessWidget {
  const StocksScreen({super.key});

  @override
  Widget build(BuildContext context) {

    const icon = Icon(
              Icons.warning,
              color: Colors.orange,
            );
    return Scaffold(

      appBar: AppBar(
        title: const Text("Stocks"),
      ),

      body: ListView(

        children: const [

          ListTile(
            title: Text("Soap"),
            subtitle: Text("2 pcs left"),
            trailing: icon,
          ),

          ListTile(
            title: Text("Milk"),
            subtitle: Text("Expires in 2 days"),
            trailing: Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),

        ],
      ),
    );
  }
}