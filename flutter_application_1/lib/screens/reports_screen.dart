import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Reports"),
      ),

      body: const Padding(
        padding: EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "Summary",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Text("• Total Used: 150"),
            Text("• Most Used: Rice"),
            Text("• Last Used: Sugar"),

          ],
        ),
      ),
    );
  }
}