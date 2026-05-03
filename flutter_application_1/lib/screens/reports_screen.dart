import 'package:flutter/material.dart';

import '../widgets/app_header.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() =>
      _ReportsScreenState();
}

class _ReportsScreenState
    extends State<ReportsScreen> {

  String filter = "Weekly";

  final Map<String, int> usageData = {

    "Soap": 90,
    "Shampoo": 70,
    "Can Goods": 50,
    "Noodles": 30,

  };

  @override
  Widget build(BuildContext context) {

    final totalUsed =
        usageData.values.reduce(
                (a, b) => a + b);

    final mostUsed =
        usageData.entries.reduce(
                (a, b) =>
            a.value > b.value
                ? a
                : b);

    return Scaffold(

      backgroundColor:
      const Color(0xffF8FAFC),

      appBar:
      const AppHeader(
        title: "Reports",
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(16),

        child: ListView(

          children: [

            Row(

              children: [

                filterTab("Today"),
                filterTab("Weekly"),
                filterTab("Monthly"),

              ],
            ),

            const SizedBox(height: 20),

            const Text(

              "Summary",

              style: TextStyle(

                fontSize: 22,
                fontWeight:
                FontWeight.bold,

              ),
            ),

            const SizedBox(height: 16),

            Row(

              children: [

                summaryCard(
                  "Total Added",
                  "320",
                  Colors.blue,
                  Icons.add_box,
                ),

                const SizedBox(width: 12),

                summaryCard(
                  "Total Used",
                  "$totalUsed",
                  Colors.green,
                  Icons.remove_circle,
                ),

              ],
            ),

            const SizedBox(height: 12),

            summaryCard(
              "Most Used",
              mostUsed.key,
              Colors.orange,
              Icons.star,
            ),

            const SizedBox(height: 24),

            const Text(

              "Most Used Items",

              style: TextStyle(

                fontSize: 20,
                fontWeight:
                FontWeight.bold,

              ),
            ),

            const SizedBox(height: 20),

            Container(

              padding:
              const EdgeInsets.all(16),

              decoration:
              BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(

                    color:
                    Colors.grey
                        .withOpacity(.1),

                    blurRadius: 8,

                  )

                ],
              ),

              child:
              Column(

                children:

                usageData.entries
                    .map(
                        (entry){

                      return buildBar(

                        entry.key,
                        entry.value,

                      );

                    })
                    .toList(),
              ),
            ),

            const SizedBox(height: 24),

            Row(

              children: [

                Expanded(

                  child:
                  exportButton(

                    "Export PDF",
                    Icons.picture_as_pdf,

                  ),
                ),

                const SizedBox(width: 12),

                Expanded(

                  child:
                  exportButton(

                    "Export Excel",
                    Icons.table_chart,

                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  Widget filterTab(
      String text) {

    final selected =
        filter == text;

    return Expanded(

      child: Padding(

        padding:
        const EdgeInsets.symmetric(
            horizontal: 4),

        child:
        ElevatedButton(

          onPressed: () {

            setState(() {

              filter = text;

            });

          },

          style:
          ElevatedButton
              .styleFrom(

            backgroundColor:

            selected

                ? const Color(
                0xff2563EB)

                : Colors.white,

            foregroundColor:

            selected

                ? Colors.white

                : Colors.black,

            shape:
            RoundedRectangleBorder(

              borderRadius:
              BorderRadius.circular(25),

            ),
          ),

          child: Text(text),
        ),
      ),
    );
  }

  Widget summaryCard(

      String title,
      String value,
      Color color,
      IconData icon,

      ) {

    return Expanded(

      child:
      Container(

        padding:
        const EdgeInsets.all(16),

        decoration:
        BoxDecoration(

          color: Colors.white,

          borderRadius:
          BorderRadius.circular(20),

          boxShadow: [

            BoxShadow(

              color:
              Colors.grey
                  .withOpacity(.1),

              blurRadius: 8,

            )

          ],
        ),

        child:
        Column(

          children: [

            Icon(
              icon,
              color: color,
            ),

            const SizedBox(height: 8),

            Text(

              title,

              style:
              const TextStyle(

                fontWeight:
                FontWeight.bold,

              ),
            ),

            const SizedBox(height: 8),

            Text(

              value,

              style:
              TextStyle(

                fontSize: 20,

                fontWeight:
                FontWeight.bold,

                color: color,

              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildBar(

      String name,
      int value,

      ) {

    Color barColor =
    Colors.green;

    if (value < 80) {

      barColor =
      Colors.orange;

    }

    if (value < 60) {

      barColor =
      Colors.red;

    }

    return Padding(

      padding:
      const EdgeInsets.only(
          bottom: 16),

      child:
      Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(

            name,

            style:
            const TextStyle(

              fontWeight:
              FontWeight.bold,

            ),
          ),

          const SizedBox(height: 8),

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
                        .withOpacity(.15),

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
                        barColor,

                        borderRadius:
                        BorderRadius.circular(
                            20),

                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Text("$value"),

            ],
          ),

        ],
      ),
    );
  }

  Widget exportButton(

      String text,
      IconData icon,

      ) {

    return ElevatedButton.icon(

      onPressed: () {},

      icon: Icon(icon),

      label: Text(text),

      style:
      ElevatedButton
          .styleFrom(

        backgroundColor:
        Colors.white,

        foregroundColor:
        const Color(
            0xff2563EB),

        shape:
        RoundedRectangleBorder(

          borderRadius:
          BorderRadius.circular(18),

        ),

        padding:
        const EdgeInsets.symmetric(
            vertical: 14),

      ),
    );
  }
}