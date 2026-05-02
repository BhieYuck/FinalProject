import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            const Text(
              "Reports",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Container(

              height: 200,
              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius:
                BorderRadius.circular(20),
              ),

              child: const Center(
                child: Text("Chart Placeholder"),
              ),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,

              child: Text(
                "Summary\n\n"
                "• Total Used: 150\n"
                "• Most Used: Rice\n"
                "• Last Used: Sugar",
              ),
            )

          ],
        ),
      ),
    );
  }
}