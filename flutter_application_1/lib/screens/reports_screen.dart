import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/item_model.dart';

import '../widgets/app_header.dart';

class ReportsScreen
    extends StatelessWidget {

  final List<ItemModel> items;

  const ReportsScreen({
    super.key,
    required this.items,
  });

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      appBar: const AppHeader(
        title: "Reports",
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(
          12,
        ),

        child: Column(

          children: [

            Row(

              children: [

                tab("Daily"),
                tab("Weekly"),
                tab("Monthly"),

              ],
            ),

            const SizedBox(
              height: 20,
            ),

            SizedBox(

              height: 250,

              child:
                  BarChart(

                BarChartData(

                  barGroups:
                      List.generate(

                    items.length,

                    (index) {

                      final item =
                          items[
                              index];

                      return BarChartGroupData(

                        x: index,

                        barRods: [

                          BarChartRodData(
                            toY: item
                                .usedCount
                                .toDouble(),
                          )

                        ],
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Container(

              padding:
                  const EdgeInsets
                      .all(
                12,
              ),

              color:
                  Colors.grey
                      .shade300,

              child:
                  const Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(
                      "Summary"),

                  Text(
                      "• Most Used: Soap"),

                  Text(
                      "• Last Used: Noodles"),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget tab(
      String text) {

    return Expanded(

      child:
          ElevatedButton(

        onPressed: () {},

        child: Text(
          text,
        ),
      ),
    );
  }
}