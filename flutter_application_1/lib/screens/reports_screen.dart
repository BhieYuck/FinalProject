import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/item_model.dart';
import '../models/transaction_model.dart';

import '../widgets/mobile_frame.dart';
import '../widgets/app_header.dart';
import '../widgets/category_tab.dart';
import '../widgets/summary_card.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String selectedFilter = "Today";

  List<ItemModel> get inventory => AppData.inventory;
  List<TransactionModel> get transactions => AppData.transactions;

  int get totalItems {
    int total = 0;

    for (var item in inventory) {
      total += item.quantity;
    }

    return total;
  }

  int get lowStockCount {
    int count = 0;

    for (var item in inventory) {
      if (item.quantity <= item.threshold) {
        count++;
      }
    }

    return count;
  }

  int get stockInTotal {
    int total = 0;

    for (var t in transactions) {
      if (t.type == "IN") {
        total += t.quantity;
      }
    }

    return total;
  }

  int get stockOutTotal {
    int total = 0;

    for (var t in transactions) {
      if (t.type == "OUT") {
        total += t.quantity;
      }
    }

    return total;
  }

  String get mostUsedItem {
    Map<String, int> usage = {};

    for (var t in transactions) {
      if (t.type == "OUT") {
        usage[t.itemName] =
            (usage[t.itemName] ?? 0) + t.quantity;
      }
    }

    if (usage.isEmpty) return "-";

    String winner = usage.keys.first;
    int highest = usage[winner]!;

    usage.forEach((key, value) {
      if (value > highest) {
        winner = key;
        highest = value;
      }
    });

    return winner;
  }

  @override
  Widget build(BuildContext context) {
    return MobileFrame(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [

                const AppHeader(
                  title: "Reports",
                ),

                const SizedBox(height: 16),

                Row(
                  children: [

                    Expanded(
                      child: CategoryTab(
                        title: "Today",
                        selected:
                            selectedFilter == "Today",
                        onTap: () {
                          setState(() {
                            selectedFilter = "Today";
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: CategoryTab(
                        title: "Weekly",
                        selected:
                            selectedFilter == "Weekly",
                        onTap: () {
                          setState(() {
                            selectedFilter = "Weekly";
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: CategoryTab(
                        title: "Monthly",
                        selected:
                            selectedFilter == "Monthly",
                        onTap: () {
                          setState(() {
                            selectedFilter = "Monthly";
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView(
                    children: [

                      Row(
                        children: [

                          Expanded(
                            child: SummaryCard(
                              title: "Total Items",
                              value:
                                  totalItems.toString(),
                              icon: Icons.inventory,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: SummaryCard(
                              title: "Low Stock",
                              value:
                                  lowStockCount
                                      .toString(),
                              icon:
                                  Icons.warning,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [

                          Expanded(
                            child: SummaryCard(
                              title: "Added",
                              value:
                                  stockInTotal
                                      .toString(),
                              icon:
                                  Icons.add,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: SummaryCard(
                              title: "Used",
                              value:
                                  stockOutTotal
                                      .toString(),
                              icon:
                                  Icons.remove,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      SummaryCard(
                        title: "Most Used",
                        value: mostUsedItem,
                        icon:
                            Icons.star,
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        "Analytics",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      _buildChart(),

                      const SizedBox(height: 24),

                      const Text(
                        "Recent Transactions",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      ...transactions
                          .reversed
                          .take(10)
                          .map(
                            (transaction) =>
                                _transactionTile(
                              transaction,
                            ),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _transactionTile(
    TransactionModel t,
  ) {
    bool isIn = t.type == "IN";

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      padding:
          const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),

      child: Row(
        children: [

          CircleAvatar(
            backgroundColor:
                isIn
                    ? Colors.green
                    : Colors.red,

            child: Icon(
              isIn
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,

              color: Colors.white,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(
                  t.itemName,

                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                ),

                Text(
                  t.date,
                ),
              ],
            ),
          ),

          Text(
            "${isIn ? "+" : "-"}${t.quantity}",

            style: TextStyle(
              fontWeight:
                  FontWeight.bold,

              color:
                  isIn
                      ? Colors.green
                      : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    double inHeight =
        stockInTotal == 0
            ? 20
            : stockInTotal.toDouble();

    double outHeight =
        stockOutTotal == 0
            ? 20
            : stockOutTotal.toDouble();

    return Container(
      padding:
          const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),

      child: SizedBox(
        height: 180,

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceEvenly,

          crossAxisAlignment:
              CrossAxisAlignment
                  .end,

          children: [

            _bar(
              "IN",
              inHeight,
              Colors.green,
            ),

            _bar(
              "OUT",
              outHeight,
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bar(
    String label,
    double height,
    Color color,
  ) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.end,

      children: [

        Container(
          width: 60,

          height:
              height.clamp(
                20,
                140,
              ),

          decoration:
              BoxDecoration(
            color: color,

            borderRadius:
                BorderRadius.circular(
              12,
            ),
          ),
        ),

        const SizedBox(height: 8),

        Text(label),
      ],
    );
  }
}