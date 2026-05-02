import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("StockTrack"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            const Text(
              "Hello, User!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: const [

                InfoCard("Total", "100"),
                InfoCard("Low", "9"),
                InfoCard("Categories", "20"),

              ],
            ),

            const SizedBox(height: 30),

            Expanded(
              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Text(
                  "Recent Activity\n\n"
                  "Added: Rice\n"
                  "Updated: Soap",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {

  final String title;
  final String value;

  const InfoCard(
      this.title,
      this.value,
      {super.key}
      );

  @override
  Widget build(BuildContext context) {

    return Card(

      child: SizedBox(
        width: 100,
        height: 70,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Text(title),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )

          ],
        ),
      ),
    );
  }
}