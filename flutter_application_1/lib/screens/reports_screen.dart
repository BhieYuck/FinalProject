import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

import '../data/app_data.dart';

import '../models/transaction_model.dart';

import '../widgets/app_header.dart';
import '../widgets/mobile_frame.dart';
import '../widgets/category_tab.dart';
import '../widgets/summary_card.dart';

class ReportsScreen
    extends StatefulWidget {

  const ReportsScreen({
    super.key,
  });

  @override
  State<ReportsScreen>
  createState() =>
      _ReportsScreenState();
}

class _ReportsScreenState
    extends State<ReportsScreen> {

  String selectedFilter =
      "Today";

  List<TransactionModel>
  get filteredTransactions {

    final now =
    DateTime.now();

    return transactions.where(
            (transaction){

          final difference =

          now.difference(
              transaction.date)

              .inDays;

          if(
          selectedFilter
              ==
              "Today"){

            return
                difference
                <=
                0;
          }

          if(
          selectedFilter
              ==
              "Weekly"){

            return
                difference
                <=
                7;
          }

          return
              difference
              <=
              30;

        }).toList();
  }

  int get totalAdded {

    int total = 0;

    for(
    final transaction
    in
    filteredTransactions){

      if(
      transaction.type
          ==
          "In"){

        total +=
            transaction
                .quantity;
      }
    }

    return total;
  }

  int get totalUsed {

    int total = 0;

    for(
    final transaction
    in
    filteredTransactions){

      if(
      transaction.type
          ==
          "Out"){

        total +=
            transaction
                .quantity;
      }
    }

    return total;
  }

  String get mostUsedItem {

    Map<String,int>
    usage = {};

    for(
    final transaction
    in
    filteredTransactions){

      if(
      transaction.type
          ==
          "Out"){

        usage.update(

          transaction.itemName,

              (value){

            return
                value
                +
                transaction.quantity;

          },

          ifAbsent:(){

            return
                transaction.quantity;

          },
        );
      }
    }

    if(
    usage.isEmpty){

      return
          "-";
    }

    String best =
        usage.keys.first;

    int max =
    usage.values.first;

    usage.forEach(
            (key,value){

          if(
          value
              >
              max){

            max =
                value;

            best =
                key;
          }

        });

    return best;
  }

  @override
  Widget build(
      BuildContext context) {

    return MobileFrame(

      child:
      Scaffold(

        backgroundColor:
        const Color(
            0xffF5F7FB),

        appBar:
        const AppHeader(
          title:
          "Reports",
        ),

        body:
        Padding(

          padding:
          const EdgeInsets.all(
              16),

          child:
          ListView(

            children: [

              Row(

                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

                children: [

                  CategoryTab(

                    text:
                    "Today",

                    active:

                    selectedFilter
                        ==
                        "Today",

                    onTap:(){

                      setState(() {

                        selectedFilter =
                        "Today";

                      });

                    },
                  ),

                  CategoryTab(

                    text:
                    "Weekly",

                    active:

                    selectedFilter
                        ==
                        "Weekly",

                    onTap:(){

                      setState(() {

                        selectedFilter =
                        "Weekly";

                      });

                    },
                  ),

                  CategoryTab(

                    text:
                    "Monthly",

                    active:

                    selectedFilter
                        ==
                        "Monthly",

                    onTap:(){

                      setState(() {

                        selectedFilter =
                        "Monthly";

                      });

                    },
                  ),

                ],
              ),

              const SizedBox(
                  height: 20),

              Row(

                children: [

                  SummaryCard(

                    icon:
                    Icons.add,

                    title:
                    "Added",

                    value:
                    "$totalAdded",

                    color:
                    Colors.green,
                  ),

                  const SizedBox(
                      width: 10),

                  SummaryCard(

                    icon:
                    Icons.remove,

                    title:
                    "Used",

                    value:
                    "$totalUsed",

                    color:
                    Colors.red,
                  ),

                ],
              ),

              const SizedBox(
                  height: 10),

              Row(

                children: [

                  SummaryCard(

                    icon:
                    Icons.star,

                    title:
                    "Most Used",

                    value:
                    mostUsedItem,

                    color:
                    Colors.orange,
                  ),

                  const Expanded(
                    child:
                    SizedBox(),
                  ),

                ],
              ),

              const SizedBox(
                  height: 24),

              const Text(

                "Usage Analytics",

                style:
                TextStyle(

                  fontSize:
                  20,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(
                  height: 20),

              SizedBox(

                height:
                300,

                child:
                BarChart(

                  BarChartData(

                    borderData:
                    FlBorderData(
                      show:
                      false,
                    ),

                    gridData:
                    const FlGridData(
                      show:
                      false,
                    ),

                    titlesData:
                    const FlTitlesData(),

                    barGroups: [

                      BarChartGroupData(

                        x: 1,

                        barRods: [

                          BarChartRodData(

                            toY:
                            totalAdded
                                .toDouble(),
                          ),

                        ],
                      ),

                      BarChartGroupData(

                        x: 2,

                        barRods: [

                          BarChartRodData(

                            toY:
                            totalUsed
                                .toDouble(),
                          ),

                        ],
                      ),

                      BarChartGroupData(

                        x: 3,

                        barRods: [

                          BarChartRodData(

                            toY:

                            filteredTransactions
                                .length

                                .toDouble(),
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ),

              const SizedBox(
                  height: 30),

              const Text(

                "Recent Transactions",

                style:
                TextStyle(

                  fontSize:
                  20,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(
                  height: 12),

              ...filteredTransactions
                  .reversed

                  .map(

                      (transaction){

                    return Card(

                      shape:
                      RoundedRectangleBorder(

                        borderRadius:
                        BorderRadius.circular(
                            20),
                      ),

                      child:
                      ListTile(

                        leading:
                        CircleAvatar(

                          backgroundColor:

                          transaction.type
                              ==
                              "In"

                              ?

                          Colors.green
                              .withOpacity(
                              .15)

                              :

                          Colors.red
                              .withOpacity(
                              .15),

                          child:
                          Icon(

                            transaction.type
                                ==
                                "In"

                                ?

                            Icons.arrow_downward

                                :

                            Icons.arrow_upward,

                            color:

                            transaction.type
                                ==
                                "In"

                                ?

                            Colors.green

                                :

                            Colors.red,
                          ),
                        ),

                        title:
                        Text(

                            transaction
                                .itemName),

                        subtitle:
                        Text(

                          transaction
                              .date

                              .toString()

                              .substring(
                              0,
                              16),
                        ),

                        trailing:
                        Text(

                          "${transaction.type} ${transaction.quantity}",

                          style:
                          TextStyle(

                            fontWeight:
                            FontWeight.bold,

                            color:

                            transaction.type
                                ==
                                "In"

                                ?

                            Colors.green

                                :

                            Colors.red,
                          ),
                        ),
                      ),
                    );

                  }),

              const SizedBox(
                  height: 80),

            ],
          ),
        ),
      ),
    );
  }
}