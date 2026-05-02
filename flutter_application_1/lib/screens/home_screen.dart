import 'package:flutter/material.dart';

import '../models/item_model.dart';

import '../widgets/custom_card.dart';

class HomeScreen extends StatelessWidget {

  final List<ItemModel> items;

  final Function(
    String,
    int,
    String,
  ) onAdd;

  const HomeScreen({

    super.key,

    required this.items,

    required this.onAdd,

  });

  @override
  Widget build(
      BuildContext context) {

    final lowStock =
    items.where(
            (e) =>
        e.isLowStock)
        .length;

    final categories =
    items
        .map(
            (e) =>
        e.category)
        .toSet()
        .length;

    return Scaffold(

      backgroundColor:
      Colors.grey.shade100,

      body: Column(

        children: [

          // HEADER
          Container(

            height: 95,

            padding:
            const EdgeInsets
                .only(
              left: 16,
              right: 16,
              top: 40,
            ),

            color: Colors.blue,

            child: Row(

              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

              children: const [

                Text(

                  "StockTrack",

                  style:
                  TextStyle(

                    color:
                    Colors.white,

                    fontSize:
                    22,

                    fontWeight:
                    FontWeight
                        .bold,

                    fontStyle:
                    FontStyle
                        .italic,
                  ),
                ),

                Icon(

                  Icons
                      .notifications,

                  color:
                  Colors.white,

                  size: 28,
                ),

              ],
            ),
          ),

          Expanded(

            child: Padding(

              padding:
              const EdgeInsets
                  .all(
                  12),

              child: Column(

                children: [

                  const SizedBox(
                      height:
                      8),

                  const Text(

                    "Hello, User!",

                    style:
                    TextStyle(

                      fontSize:
                      26,

                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),

                  const SizedBox(
                      height:
                      16),

                  // STATS
                  Row(

                    children: [

                      statCard(
                        "Total Items",
                        items
                            .length
                            .toString(),
                      ),

                      statCard(
                        "Low Stock",
                        lowStock
                            .toString(),
                      ),

                      statCard(
                        "Categories",
                        categories
                            .toString(),
                      ),

                    ],
                  ),

                  const SizedBox(
                      height:
                      14),

                  // ACTIVITY PANEL
                  Expanded(

                    child:
                    CustomCard(

                      child:
                      Column(

                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [

                          const Text(

                            "Today's Recent Activity",

                            style:
                            TextStyle(

                              fontSize:
                              18,

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const Divider(),

                          ...items
                              .take(3)
                              .map(

                                  (e){

                                return Padding(

                                  padding:
                                  const EdgeInsets.only(
                                      bottom: 10),

                                  child:
                                  Text(

                                    "Added : ${e.name} (${e.quantity} pcs)",

                                    style:
                                    const TextStyle(
                                      fontSize:
                                      16,
                                    ),
                                  ),
                                );

                              }),

                          const SizedBox(
                              height:
                              25),

                          const Text(

                            "Yesterday Activity",

                            style:
                            TextStyle(

                              fontSize:
                              18,

                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const Divider(),

                          const Text(
                            "Updated : Soap (5 pcs)",
                          ),

                          const SizedBox(
                              height:
                              8),

                          const Text(
                            "Added : Rice (10 pcs)",
                          ),

                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                      height:
                      12),

                  // ADD BUTTON
                  SizedBox(

                    width: 180,

                    child:
                    ElevatedButton.icon(

                      style:
                      ElevatedButton
                          .styleFrom(

                        backgroundColor:
                        Colors.blue,

                        shape:
                        RoundedRectangleBorder(

                          borderRadius:
                          BorderRadius.circular(
                              12),
                        ),
                      ),

                      onPressed:
                          () {

                        showAddDialog(
                          context,
                        );

                      },

                      icon:
                      const Icon(
                        Icons.add,
                        color:
                        Colors.white,
                      ),

                      label:
                      const Text(

                        "Add Item",

                        style:
                        TextStyle(
                          color:
                          Colors.white,
                          fontSize:
                          18,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                      height:
                      10),

                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget statCard(
      String title,
      String value) {

    return Expanded(

      child: Container(

        margin:
        const EdgeInsets
            .all(2),

        padding:
        const EdgeInsets
            .all(8),

        decoration:
        BoxDecoration(

          color:
          Colors.blue,

          borderRadius:
          BorderRadius.circular(
              8),

          border:
          Border.all(
            color:
            Colors.black54,
          ),
        ),

        child: Column(

          children: [

            Text(

              title,

              style:
              const TextStyle(
                color:
                Colors.white,
                fontSize:
                14,
              ),
            ),

            const SizedBox(
                height:
                5),

            Text(

              value,

              style:
              const TextStyle(

                color:
                Colors.white,

                fontSize:
                24,

                fontWeight:
                FontWeight
                    .bold,
              ),
            ),

          ],
        ),
      ),
    );
  }

  void showAddDialog(
      BuildContext context) {

    final name =
    TextEditingController();

    final qty =
    TextEditingController();

    String category =
        "Food";

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text(
              "Add Item"),

          content:
          Column(

            mainAxisSize:
            MainAxisSize
                .min,

            children: [

              TextField(
                controller:
                name,

                decoration:
                const InputDecoration(
                  hintText:
                  "Item Name",
                ),
              ),

              TextField(
                controller:
                qty,

                decoration:
                const InputDecoration(
                  hintText:
                  "Quantity",
                ),
              ),

              DropdownButton(

                value:
                category,

                items:
                const [

                  DropdownMenuItem(
                    value:
                    "Food",

                    child:
                    Text(
                        "Food"),
                  ),

                  DropdownMenuItem(
                    value:
                    "Supplies",

                    child:
                    Text(
                        "Supplies"),
                  ),

                ],

                onChanged:
                    (value){

                  category =
                  value!;
                },
              )

            ],
          ),

          actions: [

            ElevatedButton(

              onPressed:
                  () {

                onAdd(

                  name.text,

                  int.parse(
                      qty.text),

                  category,

                );

                Navigator.pop(
                    context);

              },

              child:
              const Text(
                  "Save"),
            )

          ],
        );
      },
    );
  }
}