import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,

        title: const Text(
          "StockTrack",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            const Text(
              "Hello, User!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: const [

                Expanded(
                  child: StatsCard(
                    "Total Items",
                    "100",
                  ),
                ),

                SizedBox(width: 8),

                Expanded(
                  child: StatsCard(
                    "Low Stock",
                    "9",
                  ),
                ),

                SizedBox(width: 8),

                Expanded(
                  child: StatsCard(
                    "Categories",
                    "20",
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(

                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(25),
                ),

                child: const Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Today's Recent Activity",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    SizedBox(height: 20),

                    Text("Added : Rice (10pcs)"),
                    SizedBox(height: 10),
                    Text("Updated : Soap (5pcs)"),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(

                onPressed: () {},

                icon: const Icon(Icons.add),

                label: const Text(
                  "Add Item",
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  AppColors.primary,

                  foregroundColor:
                  Colors.white,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

class StatsCard extends StatelessWidget {

  final String title;
  final String value;

  const StatsCard(
      this.title,
      this.value,
      {super.key});

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius:
        BorderRadius.circular(10),
      ),

      child: Column(

        children: [

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight:
              FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }
}