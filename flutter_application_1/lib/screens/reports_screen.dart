import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../widgets/app_header.dart';
import '../widgets/summary_card.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() =>
      _ReportsScreenState();
}

class _ReportsScreenState
    extends State<ReportsScreen> {

  @override
  Widget build(BuildContext context) {

    final totalItems =
        inventory.length;

    final totalStock =
    inventory.fold(
      0,
      (sum, item) =>
      sum +
          (item["quantity"] as int),
    );

    final totalIn =
    transactions
        .where(
            (tx) =>
        tx["type"] == "In")
        .fold(
      0,
      (sum, tx) =>
      sum +
          (tx["qty"] as int),
    );

    final totalOut =
    transactions
        .where(
            (tx) =>
        tx["type"] == "Out")
        .fold(
      0,
      (sum, tx) =>
      sum +
          (tx["qty"] as int),
    );

    Map<String, int>
    usageData = {};

    for (var tx
    in transactions) {

      if (tx["type"]
          == "Out") {

        final name =
        tx["name"] as String;

        usageData[name] =

            (usageData[name]
            ?? 0)

                +

                (tx["qty"]
                as int);
      }
    }

    String mostUsed =
        "None";

    if (usageData
        .isNotEmpty) {

      mostUsed =
          usageData.entries
              .reduce(
                  (a, b) {

                return
                a.value >
                    b.value

                    ? a

                    : b;

              })
              .key;
    }

    return Scaffold(

      backgroundColor:
      const Color(
          0xffF8FAFC),

      appBar:
      const AppHeader(
        title:
        "Reports",
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(
            16),

        child:
        ListView(

          children: [

            Row(

              children: [

                summary(
                  "Items",
                  "$totalItems",
                  Icons.inventory,
                  Colors.blue,
                ),

                const SizedBox(
                    width: 12),

                summary(
                  "Stock",
                  "$totalStock",
                  Icons.layers,
                  Colors.green,
                ),

              ],
            ),

            const SizedBox(
                height: 12),

            Row(

              children: [

                summary(
                  "IN",
                  "$totalIn",
                  Icons.add,
                  Colors.blue,
                ),

                const SizedBox(
                    width: 12),

                summary(
                  "OUT",
                  "$totalOut",
                  Icons.remove,
                  Colors.red,
                ),

              ],
            ),

            const SizedBox(
                height: 12),

            summary(
              "Most Used",
              mostUsed,
              Icons.star,
              Colors.orange,
            ),

            const SizedBox(
                height: 24),

            const Text(

              "Usage Chart",

              style:
              TextStyle(

                fontSize: 20,

                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 16),

            ...usageData.entries
                .map(
                    (entry) {

                  return buildBar(

                    entry.key,
                    entry.value,

                  );

                }),

          ],
        ),
      ),
    );
  }

  Widget summary(

      String title,
      String value,
      IconData icon,
      Color color,

      ) {

    return Expanded(

      child:
      SummaryCard(

        title:
        title,

        value:
        value,

        icon:
        icon,

        color:
        color,
      ),
    );
  }

  Widget buildBar(

      String name,
      int value,

      ) {

    return Padding(

      padding:
      const EdgeInsets.only(
          bottom: 16),

      child:
      Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(name),

          const SizedBox(
              height: 8),

          Row(

            children: [

              Expanded(

                child:
                Container(

                  height: 18,

                  decoration:
                  BoxDecoration(

                    color:
                    Colors.grey
                        .withOpacity(
                        .2),

                    borderRadius:
                    BorderRadius.circular(
                        20),
                  ),

                  child:
                  FractionallySizedBox(

                    alignment:
                    Alignment.centerLeft,

                    widthFactor:
                    value / 100,

                    child:
                    Container(

                      decoration:
                      BoxDecoration(

                        color:
                        Colors.blue,

                        borderRadius:
                        BorderRadius.circular(
                            20),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                  width: 10),

              Text("$value"),

            ],
          ),

        ],
      ),
    );
  }
}